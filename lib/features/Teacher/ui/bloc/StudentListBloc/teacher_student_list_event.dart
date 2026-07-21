part of 'teacher_student_list_bloc.dart';

sealed class TeacherStudentListEvent extends Equatable {
  const TeacherStudentListEvent();

  @override
  List<Object?> get props => [];
}

class GetTeacherStudentsEvent extends TeacherStudentListEvent {
  final int localGradeNumber;
  final int localSectionNumber;
  final int localSubjectId;

  const GetTeacherStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
    required this.localSubjectId,
  });

  @override
  List<Object?> get props => [localGradeNumber, localSectionNumber, localSubjectId];
}

class RefreshTeacherStudentsEvent extends TeacherStudentListEvent {
  final int localGradeNumber;
  final int localSectionNumber;
  final int localSubjectId;

  const RefreshTeacherStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
    required this.localSubjectId,
  });

  @override
  List<Object?> get props => [localGradeNumber, localSectionNumber, localSubjectId];
}

class RevalidateTeacherStudentsEvent extends TeacherStudentListEvent {
  final int localGradeNumber;
  final int localSectionNumber;
  final int localSubjectId;

  const RevalidateTeacherStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
    required this.localSubjectId,
  });

  @override
  List<Object?> get props => [localGradeNumber, localSectionNumber, localSubjectId];
}

class WatchCachedTeacherStudentsEvent extends TeacherStudentListEvent {
  final int localGradeNumber;
  final int localSectionNumber;
  final int localSubjectId;

  const WatchCachedTeacherStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
    required this.localSubjectId,
  });

  @override
  List<Object?> get props => [localGradeNumber, localSectionNumber, localSubjectId];
}

class UpdateCachedTeacherStudentsEvent extends TeacherStudentListEvent {
  final StudentsBySectionEntity students;

  const UpdateCachedTeacherStudentsEvent({required this.students});

  @override
  List<Object?> get props => [students];
}