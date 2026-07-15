import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';
import 'package:school/features/Counselor/domain/UseCases/GradeAndSectionUseCase.dart';

part 'grade_event.dart';
part 'grade_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  StreamSubscription? _subscription;
  final CounselorRepo counselorRepo;
  Stream<List<Gradeentity>>? _cachedStream;
  final GradeAndSectionUseCase gradeAndSectionUseCase;
  GradeBloc({required this.counselorRepo, required this.gradeAndSectionUseCase})
    : super(GradeInitial()) {
    on<GetGradeEvent>(_getAll);
    on<RefreshGradeEvent>(_refresh);
    on<UpdateCachedGradeEvent>(_updateCache);
    on<RevalidateGradeEvent>(_revalidateGrade);
    on<WatchCachedGradeEvent>(_watchCachedGradeEvent);
  }
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  FutureOr<void> _getAll(GetGradeEvent event, Emitter<GradeState> emit) async {
    emit(GradeLoading());
    final either = await gradeAndSectionUseCase();
    either.fold((ifLeft) {
      emit(GradeError(message: mapFailureToMessage(ifLeft)));
    }, (ifRight) => emit(GradeLoaded(grade: ifRight, isRevalidating: false)));
  }

  FutureOr<void> _refresh(
    RefreshGradeEvent event,
    Emitter<GradeState> emit,
  ) async {
    emit(GradeLoading());
    final either = await counselorRepo.getGradeAndSectionWithCache();
    either.fold(
      (ifLeft) => emit(GradeError(message: mapFailureToMessage(ifLeft))),
      (ifRight) => emit(GradeLoaded(grade: ifRight, isRevalidating: false)),
    );
  }

  FutureOr<void> _revalidateGrade(
    RevalidateGradeEvent event,
    Emitter<GradeState> emit,
  ) async {
    if (state is GradeLoaded) {
      final currentState = state as GradeLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }
    final networkEither = await counselorRepo.getGradeAndSection();
    networkEither.fold(
      (ifLeft) {
        if (state is GradeLoaded) {
          final currentState = state as GradeLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(ifLeft),
            ),
          );
        }
      },
      (ifRight) {
        if (state is GradeLoaded) {
          final currentState = state as GradeLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  FutureOr<void> _updateCache(
    UpdateCachedGradeEvent event,
    Emitter<GradeState> emit,
  ) async {
    if (state is GradeLoaded) {
      final currentState = state as GradeLoaded;
      emit(currentState.copyWith(grade: event.grade));
    } else {
      emit(GradeLoaded(grade: event.grade, isRevalidating: false));
    }
  }

  FutureOr<void> _watchCachedGradeEvent(
    WatchCachedGradeEvent event,
    Emitter<GradeState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = counselorRepo.watchCachedgetGradeAndSection();
    _subscription = _cachedStream?.listen((grade) {
      if (state is GradeLoaded) {
        add(UpdateCachedGradeEvent(grade: grade));
      }
    });
  }
}
