part of 'school_info_bloc.dart';

class GetSchoolsEvent extends SchoolInfoEvent {}

class RefreshSchoolsEvent extends SchoolInfoEvent {}

class RevalidateSchoolsEvent extends SchoolInfoEvent {}

sealed class SchoolInfoEvent extends Equatable {
  const SchoolInfoEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCachedSchoolsEvent extends SchoolInfoEvent {
  final Schoolwithteacherentity schools;

  const UpdateCachedSchoolsEvent({required this.schools});

  @override
  List<Object> get props => [schools];
}

class WatchCachedSchoolsEvent extends SchoolInfoEvent {}
