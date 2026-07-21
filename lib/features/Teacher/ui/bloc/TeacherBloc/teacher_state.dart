part of 'teacher_bloc.dart';

final class TeacherError extends TeacherState {
  final String message;

  const TeacherError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TeacherInitial extends TeacherState {}

final class TeacherLoaded extends TeacherState {
  final TeacherFullprofileentity profile;
  final bool isRevalidating;
  final String? errorMessage;

  const TeacherLoaded({
    required this.profile,
    this.isRevalidating = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [profile, isRevalidating, errorMessage];

  TeacherLoaded copyWith({
    TeacherFullprofileentity? profile,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return TeacherLoaded(
      profile: profile ?? this.profile,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final class TeacherLoading extends TeacherState {}

sealed class TeacherState extends Equatable {
  const TeacherState();

  @override
  List<Object?> get props => [];
}
