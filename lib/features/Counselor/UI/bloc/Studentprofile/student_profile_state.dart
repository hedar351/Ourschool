part of 'student_profile_bloc.dart';

final class StudentProfileError extends StudentProfileState {
  final String message;

  const StudentProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class StudentProfileInitial extends StudentProfileState {}

final class StudentProfileLoaded extends StudentProfileState {
  final CounselorStudentfullprofile profile;
  final bool isRevalidating;
  final String? errorMessage;

  const StudentProfileLoaded({
    required this.profile,
    this.isRevalidating = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [profile, isRevalidating, errorMessage];

  StudentProfileLoaded copyWith({
    CounselorStudentfullprofile? profile,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return StudentProfileLoaded(
      profile: profile ?? this.profile,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final class StudentProfileLoading extends StudentProfileState {}

sealed class StudentProfileState extends Equatable {
  const StudentProfileState();

  @override
  List<Object?> get props => [];
}
