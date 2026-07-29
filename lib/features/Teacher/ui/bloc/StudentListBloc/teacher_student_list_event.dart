part of 'teacher_student_list_bloc.dart';

class GetTeacherStudentsEvent extends TeacherStudentListEvent {
  final int localGradeNumber;
  final int localSectionNumber;
  final int localSubjectId;
  final int schoolId;
  const GetTeacherStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
    required this.localSubjectId,
    required this.schoolId,
  });

  @override
  List<Object?> get props => [
    localGradeNumber,
    localSectionNumber,
    localSubjectId,
    schoolId,
  ];
}

class RefreshTeacherStudentsEvent extends TeacherStudentListEvent {
  final int localGradeNumber;
  final int localSectionNumber;
  final int localSubjectId;
  final int schoolId;

  const RefreshTeacherStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
    required this.localSubjectId,
    required this.schoolId,
  });

  @override
  List<Object?> get props => [
    localGradeNumber,
    localSectionNumber,
    localSubjectId,
    schoolId,
  ];
}

class RevalidateTeacherStudentsEvent extends TeacherStudentListEvent {
  final int localGradeNumber;
  final int localSectionNumber;
  final int localSubjectId;
  final int schoolId;

  const RevalidateTeacherStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
    required this.localSubjectId,
    required this.schoolId,
  });

  @override
  List<Object?> get props => [
    localGradeNumber,
    localSectionNumber,
    localSubjectId,
    schoolId,
  ];
}

sealed class TeacherStudentListEvent extends Equatable {
  const TeacherStudentListEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCachedTeacherStudentsEvent extends TeacherStudentListEvent {
  final StudentsBySectionEntity students;

  const UpdateCachedTeacherStudentsEvent({required this.students});

  @override
  List<Object?> get props => [students];
}

class WatchCachedTeacherStudentsEvent extends TeacherStudentListEvent {
  final int localGradeNumber;
  final int localSectionNumber;
  final int localSubjectId;
  final int schoolId;

  const WatchCachedTeacherStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
    required this.localSubjectId,
    required this.schoolId,
  });

  @override
  List<Object?> get props => [
    localGradeNumber,
    localSectionNumber,
    localSubjectId,
    schoolId,
  ];
}
