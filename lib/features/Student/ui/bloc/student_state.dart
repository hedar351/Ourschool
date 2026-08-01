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

  const StudentLoaded({required this.profile, this.isRevalidating = false});

  @override
  List<Object?> get props => [profile, isRevalidating];

  StudentLoaded copyWith({
    List<Studentfullprofileentity>? profile,
    bool? isRevalidating,
  }) {
    return StudentLoaded(
      profile: profile ?? this.profile,
      isRevalidating: isRevalidating ?? this.isRevalidating,
    );
  }
}

class StudentLoading extends StudentState {}

sealed class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}
