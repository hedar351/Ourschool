part of 'student_bloc.dart';

class StudentError extends StudentState {
  final String message;

  const StudentError({required this.message});

  @override
  List<Object> get props => [message];
}

class StudentInitial extends StudentState {}

class StudentLoaded extends StudentState {
  final List<Studentfullprofileentity> profile;
  final bool isRevalidating;
  final String? errorMessage;

  const StudentLoaded({
    required this.profile,
    this.isRevalidating = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [profile, isRevalidating, errorMessage];

  StudentLoaded copyWith({
    List<Studentfullprofileentity>? profile,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return StudentLoaded(
      profile: profile ?? this.profile,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class StudentLoading extends StudentState {}

sealed class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}
