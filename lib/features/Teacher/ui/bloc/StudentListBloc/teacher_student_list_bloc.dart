import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

part 'teacher_student_list_event.dart';
part 'teacher_student_list_state.dart';

class TeacherStudentListBloc
    extends Bloc<TeacherStudentListEvent, TeacherStudentListState> {
  final Teacherrepo teacherRepo;
  Stream<StudentsBySectionEntity>? _cachedStream;
  StreamSubscription? _subscription;

  TeacherStudentListBloc({required this.teacherRepo})
    : super(TeacherStudentListInitial()) {
    on<GetTeacherStudentsEvent>(_onGet);
    on<RefreshTeacherStudentsEvent>(_onRefresh);
    on<WatchCachedTeacherStudentsEvent>(_onWatchCached);
    on<RevalidateTeacherStudentsEvent>(_onRevalidate);
    on<UpdateCachedTeacherStudentsEvent>(_onUpdateCached);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  // التحميل الأولي
  FutureOr<void> _onGet(
    GetTeacherStudentsEvent event,
    Emitter<TeacherStudentListState> emit,
  ) async {
    emit(TeacherStudentListLoading());
    final either = await teacherRepo.getStudents(
      event.localGradeNumber,
      event.localSectionNumber,
      event.localSubjectId,
      event.schoolId,
    );
    either.fold(
      (failure) =>
          emit(TeacherStudentListError(message: mapFailureToMessage(failure))),
      (students) {
        emit(
          TeacherStudentListLoaded(students: students, isRevalidating: false),
        );
        add(
          WatchCachedTeacherStudentsEvent(
            localGradeNumber: event.localGradeNumber,
            localSectionNumber: event.localSectionNumber,
            localSubjectId: event.localSubjectId,
            schoolId: event.schoolId,
          ),
        );
      },
    );
  }

  // التحديث اليدوي (تحديث خلفي)
  FutureOr<void> _onRefresh(
    RefreshTeacherStudentsEvent event,
    Emitter<TeacherStudentListState> emit,
  ) async {
    if (state is TeacherStudentListLoaded) {
      final currentState = state as TeacherStudentListLoaded;
      emit(currentState.copyWith(isRevalidating: true));

      final either = await teacherRepo.getStudentsWithCache(
        event.localGradeNumber,
        event.localSectionNumber,
        event.localSubjectId,
        event.schoolId,
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
      // إذا لم تكن الحالة محملة، نستخدم التحميل الكامل
      add(
        GetTeacherStudentsEvent(
          localGradeNumber: event.localGradeNumber,
          localSectionNumber: event.localSectionNumber,
          localSubjectId: event.localSubjectId,
          schoolId: event.schoolId,
        ),
      );
    }
  }

  // إعادة التحقق من الكاش
  FutureOr<void> _onRevalidate(
    RevalidateTeacherStudentsEvent event,
    Emitter<TeacherStudentListState> emit,
  ) async {
    if (state is TeacherStudentListLoaded) {
      final currentState = state as TeacherStudentListLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }
    final networkEither = await teacherRepo.getStudents(
      event.localGradeNumber,
      event.localSectionNumber,
      event.localSubjectId,
      event.schoolId,
    );
    networkEither.fold(
      (failure) {
        if (state is TeacherStudentListLoaded) {
          final currentState = state as TeacherStudentListLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (newStudents) {
        if (state is TeacherStudentListLoaded) {
          final currentState = state as TeacherStudentListLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  // تحديث الحالة عند تغيير الكاش
  FutureOr<void> _onUpdateCached(
    UpdateCachedTeacherStudentsEvent event,
    Emitter<TeacherStudentListState> emit,
  ) {
    if (state is TeacherStudentListLoaded) {
      final currentState = state as TeacherStudentListLoaded;
      emit(currentState.copyWith(students: event.students));
    } else {
      emit(
        TeacherStudentListLoaded(
          students: event.students,
          isRevalidating: false,
        ),
      );
    }
  }

  // بدء الاستماع للكاش
  FutureOr<void> _onWatchCached(
    WatchCachedTeacherStudentsEvent event,
    Emitter<TeacherStudentListState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = teacherRepo.watchCachedgetStudents(
      event.localGradeNumber,
      event.localSectionNumber,
      event.localSubjectId,
      event.schoolId,
    );
    _subscription = _cachedStream?.listen((students) {
      if (state is TeacherStudentListLoaded) {
        add(UpdateCachedTeacherStudentsEvent(students: students));
      }
    });
  }
}
