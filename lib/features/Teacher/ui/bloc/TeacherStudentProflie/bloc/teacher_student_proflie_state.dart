// lib/features/Teacher/ui/bloc/TeacherStudentProfile/bloc/teacher_student_profile_state.dart

import 'package:equatable/equatable.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';

final class TeacherStudentProfileError extends TeacherStudentProfileState {
  final String message;
  const TeacherStudentProfileError({required this.message});
  @override
  List<Object?> get props => [message];
}

final class TeacherStudentProfileInitial extends TeacherStudentProfileState {}

final class TeacherStudentProfileLoaded extends TeacherStudentProfileState {
  final Teacherstudentprofileentity profile;
  final bool isRevalidating;
  final String? errorMessage;

  const TeacherStudentProfileLoaded({
    required this.profile,
    this.isRevalidating = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [profile, isRevalidating, errorMessage];

  TeacherStudentProfileLoaded copyWith({
    Teacherstudentprofileentity? profile,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return TeacherStudentProfileLoaded(
      profile: profile ?? this.profile,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final class TeacherStudentProfileLoading extends TeacherStudentProfileState {}

sealed class TeacherStudentProfileState extends Equatable {
  const TeacherStudentProfileState();
  @override
  List<Object?> get props => [];
}
