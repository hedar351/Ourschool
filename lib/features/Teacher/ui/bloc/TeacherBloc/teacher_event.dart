part of 'teacher_bloc.dart';

class GetTeacherEvent extends TeacherEvent {}

class RefreshTeacherEvent extends TeacherEvent {}

class RevalidateTeacherEvent extends TeacherEvent {}

sealed class TeacherEvent extends Equatable {
  const TeacherEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCachedTeacherEvent extends TeacherEvent {
  final TeacherFullprofileentity profile;

  const UpdateCachedTeacherEvent({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class WatchCachedTeacherEvent extends TeacherEvent {}
