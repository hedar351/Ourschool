part of 'grade_bloc.dart';

final class GradeError extends GradeState {
  final String message;

  const GradeError({required this.message});
  @override
  List<Object> get props => [message];
}

final class GradeInitial extends GradeState {}

final class GradeLoaded extends GradeState {
  final List<Gradeentity> grade;
  final bool isRevalidating;
  final String? errorMessage;
  const GradeLoaded({
    required this.grade,
    this.isRevalidating = false,
    this.errorMessage,
  });
  @override
  List<Object?> get props => [grade, errorMessage, isRevalidating];

  GradeLoaded copyWith({
    List<Gradeentity>? grade,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return GradeLoaded(
      grade: grade ?? this.grade,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final class GradeLoading extends GradeState {}

sealed class GradeState extends Equatable {
  const GradeState();

  @override
  List<Object?> get props => [];
}
