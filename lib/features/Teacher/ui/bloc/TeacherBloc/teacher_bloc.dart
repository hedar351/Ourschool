import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final Teacherrepo teacherRepo;
  Stream<TeacherFullprofileentity>? _cachedStream;
  StreamSubscription? _subscription;

  TeacherBloc({required this.teacherRepo}) : super(TeacherInitial()) {
    on<GetTeacherEvent>(_onGet);
    on<RefreshTeacherEvent>(_onRefresh);
    on<WatchCachedTeacherEvent>(_onWatchCached);
    on<RevalidateTeacherEvent>(_onRevalidate);
    on<UpdateCachedTeacherEvent>(_onUpdateCached);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onGet(
    GetTeacherEvent event,
    Emitter<TeacherState> emit,
  ) async {
    emit(TeacherLoading());
    final either = await teacherRepo.getTeacherFullprofile();
    either.fold(
      (failure) => emit(TeacherError(message: mapFailureToMessage(failure))),
      (profile) {
        emit(TeacherLoaded(profile: profile, isRevalidating: false));
        add(WatchCachedTeacherEvent());
      },
    );
  }

  FutureOr<void> _onRefresh(
    RefreshTeacherEvent event,
    Emitter<TeacherState> emit,
  ) async {
    if (state is TeacherLoaded) {
      final currentState = state as TeacherLoaded;
      emit(currentState.copyWith(isRevalidating: true));

      final either = await teacherRepo.getTeacherFullprofileWithCache();
      either.fold(
        (failure) {
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        },
        (newProfile) {
          emit(
            currentState.copyWith(
              profile: newProfile,
              isRevalidating: false,
              errorMessage: null,
            ),
          );
        },
      );
    } else {
      add(GetTeacherEvent());
    }
  }

  FutureOr<void> _onRevalidate(
    RevalidateTeacherEvent event,
    Emitter<TeacherState> emit,
  ) async {
    if (state is TeacherLoaded) {
      final currentState = state as TeacherLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }
    final networkEither = await teacherRepo.getTeacherFullprofile();
    networkEither.fold(
      (failure) {
        if (state is TeacherLoaded) {
          final currentState = state as TeacherLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (newProfile) {
        if (state is TeacherLoaded) {
          final currentState = state as TeacherLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  // تحديث الحالة عند تغيير الكاش
  FutureOr<void> _onUpdateCached(
    UpdateCachedTeacherEvent event,
    Emitter<TeacherState> emit,
  ) {
    if (state is TeacherLoaded) {
      final currentState = state as TeacherLoaded;
      emit(currentState.copyWith(profile: event.profile));
    } else {
      emit(TeacherLoaded(profile: event.profile, isRevalidating: false));
    }
  }

  // بدء الاستماع للكاش
  FutureOr<void> _onWatchCached(
    WatchCachedTeacherEvent event,
    Emitter<TeacherState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = teacherRepo.watchCachedgetTeacherFullprofile();
    _subscription = _cachedStream?.listen((profile) {
      if (state is TeacherLoaded) {
        add(UpdateCachedTeacherEvent(profile: profile));
      }
    });
  }
}
