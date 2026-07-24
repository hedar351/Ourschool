// lib/features/SchoolsInfo/presentation/bloc/school_info_bloc.dart

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/SchoolWithTeacherEntity.dart';

import '../../domain/Repo/SchoolRepository.dart';
import '../../domain/UseCase/SchoolwithTeacherUseCase.dart';

part 'school_info_event.dart';
part 'school_info_state.dart';

class SchoolInfoBloc extends Bloc<SchoolInfoEvent, SchoolInfoState> {
  final SchoolwithTeacherUseCase getSchoolsUseCase;
  final SchoolRepository repository;

  Stream<Schoolwithteacherentity>? _cachedStream;
  StreamSubscription? _subscription;

  SchoolInfoBloc({required this.getSchoolsUseCase, required this.repository})
    : super(SchoolInfoInitial()) {
    on<GetSchoolsEvent>(_onGetSchools);
    on<RefreshSchoolsEvent>(_onRefreshSchools);
    on<RevalidateSchoolsEvent>(_onRevalidateSchools);
    on<WatchCachedSchoolsEvent>(_onWatchCached);
    on<UpdateCachedSchoolsEvent>(_onUpdateCachedSchools);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onGetSchools(
    GetSchoolsEvent event,
    Emitter<SchoolInfoState> emit,
  ) async {
    emit(SchoolInfoLoading());

    final either = await getSchoolsUseCase();

    either.fold(
      (failure) => emit(SchoolInfoError(message: mapFailureToMessage(failure))),
      (schools) {
        emit(SchoolInfoLoaded(schools: schools, isRevalidating: false));
        add(WatchCachedSchoolsEvent());
      },
    );
  }

  FutureOr<void> _onRefreshSchools(
    RefreshSchoolsEvent event,
    Emitter<SchoolInfoState> emit,
  ) async {
    emit(SchoolInfoLoading());

    final either = await repository.getSchoolwithteachereWithCached();

    either.fold(
      (failure) => emit(SchoolInfoError(message: mapFailureToMessage(failure))),
      (schools) {
        emit(SchoolInfoLoaded(schools: schools, isRevalidating: false));
      },
    );
  }

  FutureOr<void> _onRevalidateSchools(
    RevalidateSchoolsEvent event,
    Emitter<SchoolInfoState> emit,
  ) async {
    if (state is SchoolInfoLoaded) {
      final currentState = state as SchoolInfoLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final either = await repository.getSchoolwithteachere();

    either.fold(
      (failure) {
        if (state is SchoolInfoLoaded) {
          final currentState = state as SchoolInfoLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        } else {
          emit(SchoolInfoError(message: mapFailureToMessage(failure)));
        }
      },
      (schools) {
        if (state is SchoolInfoLoaded) {
          final currentState = state as SchoolInfoLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        } else {
          emit(SchoolInfoLoaded(schools: schools, isRevalidating: false));
        }
      },
    );
  }

  FutureOr<void> _onUpdateCachedSchools(
    UpdateCachedSchoolsEvent event,
    Emitter<SchoolInfoState> emit,
  ) {
    if (state is SchoolInfoLoaded) {
      final currentState = state as SchoolInfoLoaded;
      emit(currentState.copyWith(schools: event.schools));
    } else {
      emit(SchoolInfoLoaded(schools: event.schools, isRevalidating: false));
    }
  }

  FutureOr<void> _onWatchCached(
    WatchCachedSchoolsEvent event,
    Emitter<SchoolInfoState> emit,
  ) async {
    await _subscription?.cancel();

    _cachedStream = repository.watchCachedSchoolwithteachere();

    _subscription = _cachedStream?.listen(
      (schools) {
        add(UpdateCachedSchoolsEvent(schools: schools));
      },
      onError: (error) {
        print('❌ [Bloc] Error watching cache: $error');
      },
    );
  }
}
