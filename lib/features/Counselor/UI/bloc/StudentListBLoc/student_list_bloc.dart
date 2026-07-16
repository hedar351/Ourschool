import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Counselor/UI/bloc/StudentListBLoc/student_list_event.dart';
import 'package:school/features/Counselor/UI/bloc/StudentListBLoc/student_list_state.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';
import 'package:school/features/Counselor/domain/UseCases/StudentBySectionUseCase.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final StudentBySectionUseCase studentBySectionUseCase;
  final CounselorRepo counselorRepo;
  Stream<StudentsBySectionEntity>? _cachedStream;
  StreamSubscription? _subscription;

  StudentsBloc({
    required this.studentBySectionUseCase,
    required this.counselorRepo,
  }) : super(StudentsInitial()) {
    on<GetStudentsEvent>(_onGet);
    on<RefreshStudentsEvent>(_onRefresh);
    on<WatchCachedStudentsEvent>(_onWatchCached);
    on<RevalidateStudentsEvent>(_onRevalidate);
    on<UpdateCachedStudentsEvent>(_onUpdateCached);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onGet(
    GetStudentsEvent event,
    Emitter<StudentsState> emit,
  ) async {
    emit(StudentsLoading());
    final either = await studentBySectionUseCase(
      event.localGradeNumber,
      event.localSectionNumber,
    );
    either.fold(
      (failure) => emit(StudentsError(message: mapFailureToMessage(failure))),
      (students) {
        emit(StudentsLoaded(students: students, isRevalidating: false));
        add(
          WatchCachedStudentsEvent(
            localGradeNumber: event.localGradeNumber,
            localSectionNumber: event.localSectionNumber,
          ),
        );
      },
    );
  }

  FutureOr<void> _onRefresh(
    RefreshStudentsEvent event,
    Emitter<StudentsState> emit,
  ) async {
    if (state is StudentsLoaded) {
      final currentState = state as StudentsLoaded;
      emit(currentState.copyWith(isRevalidating: true));

      final either = await counselorRepo.getStudentsBySectionWithCache(
        event.localGradeNumber,
        event.localSectionNumber,
      );
      either.fold(
        (failure) {
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        },
        (newStudents) {
          emit(
            currentState.copyWith(
              students: newStudents,
              isRevalidating: false,
              errorMessage: null,
            ),
          );
        },
      );
    } else {
      add(
        GetStudentsEvent(
          localGradeNumber: event.localGradeNumber,
          localSectionNumber: event.localSectionNumber,
        ),
      );
    }
  }

  FutureOr<void> _onRevalidate(
    RevalidateStudentsEvent event,
    Emitter<StudentsState> emit,
  ) async {
    if (state is StudentsLoaded) {
      final currentState = state as StudentsLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }
    final networkEither = await counselorRepo.getStudentsBySection(
      event.localGradeNumber,
      event.localSectionNumber,
    );
    networkEither.fold(
      (failure) {
        if (state is StudentsLoaded) {
          final currentState = state as StudentsLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (newStudents) {
        if (state is StudentsLoaded) {
          final currentState = state as StudentsLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  FutureOr<void> _onUpdateCached(
    UpdateCachedStudentsEvent event,
    Emitter<StudentsState> emit,
  ) {
    if (state is StudentsLoaded) {
      final currentState = state as StudentsLoaded;
      emit(currentState.copyWith(students: event.students));
    } else {
      emit(StudentsLoaded(students: event.students, isRevalidating: false));
    }
  }

  FutureOr<void> _onWatchCached(
    WatchCachedStudentsEvent event,
    Emitter<StudentsState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = counselorRepo.watchCachedgetStudentsBySection(
      event.localGradeNumber,
      event.localSectionNumber,
    );
    _subscription = _cachedStream?.listen((students) {
      if (state is StudentsLoaded) {
        add(UpdateCachedStudentsEvent(students: students));
      }
    });
  }
}
