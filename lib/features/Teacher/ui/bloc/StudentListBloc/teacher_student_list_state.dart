part of 'teacher_student_list_bloc.dart';

final class TeacherStudentListError extends TeacherStudentListState {
  final String message;

  const TeacherStudentListError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TeacherStudentListInitial extends TeacherStudentListState {}

final class TeacherStudentListLoaded extends TeacherStudentListState {
  final StudentsBySectionEntity students;
  final bool isRevalidating;
  final String? errorMessage;

  const TeacherStudentListLoaded({
    required this.students,
    this.isRevalidating = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [students, isRevalidating, errorMessage];

  TeacherStudentListLoaded copyWith({
    StudentsBySectionEntity? students,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return TeacherStudentListLoaded(
      students: students ?? this.students,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final class TeacherStudentListLoading extends TeacherStudentListState {}

sealed class TeacherStudentListState extends Equatable {
  const TeacherStudentListState();

  @override
  List<Object?> get props => [];
}