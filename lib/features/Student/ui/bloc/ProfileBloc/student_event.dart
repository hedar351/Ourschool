part of 'student_bloc.dart';

class GetStudentProfileEvent extends StudentEvent {}

class RefreshStudentProfileEvent extends StudentEvent {}

class RevalidateStudentProfileEvent extends StudentEvent {}

sealed class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCachedStudentProfileEvent extends StudentEvent {
  final List<Studentfullprofileentity> profile;

  const UpdateCachedStudentProfileEvent({required this.profile});

  @override
  List<Object> get props => [profile];
}

class WatchCachedStudentProfileEvent extends StudentEvent {}
