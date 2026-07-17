part of 'student_profile_bloc.dart';

class GetStudentProfileEvent extends StudentProfileEvent {
  final int localStudentNumber;

  const GetStudentProfileEvent({required this.localStudentNumber});

  @override
  List<Object?> get props => [localStudentNumber];
}

class RefreshStudentProfileEvent extends StudentProfileEvent {
  final int localStudentNumber;

  const RefreshStudentProfileEvent({required this.localStudentNumber});

  @override
  List<Object?> get props => [localStudentNumber];
}

class RevalidateStudentProfileEvent extends StudentProfileEvent {
  final int localStudentNumber;

  const RevalidateStudentProfileEvent({required this.localStudentNumber});

  @override
  List<Object?> get props => [localStudentNumber];
}

sealed class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCachedStudentProfileEvent extends StudentProfileEvent {
  final CounselorStudentfullprofile profile;

  const UpdateCachedStudentProfileEvent({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class WatchCachedStudentProfileEvent extends StudentProfileEvent {
  final int localStudentNumber;

  const WatchCachedStudentProfileEvent({required this.localStudentNumber});

  @override
  List<Object?> get props => [localStudentNumber];
}
