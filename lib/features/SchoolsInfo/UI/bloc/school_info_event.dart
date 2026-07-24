// lib/features/SchoolsInfo/presentation/bloc/school_info_event.dart

part of 'school_info_bloc.dart';

sealed class SchoolInfoEvent extends Equatable {
  const SchoolInfoEvent();

  @override
  List<Object?> get props => [];
}class GetSchoolsEvent extends SchoolInfoEvent {}
class RefreshSchoolsEvent extends SchoolInfoEvent {}

class RevalidateSchoolsEvent extends SchoolInfoEvent {}

class UpdateCachedSchoolsEvent extends SchoolInfoEvent {
  final Schoolwithteacherentity schools;

  const UpdateCachedSchoolsEvent({required this.schools});

  @override
  List<Object> get props => [schools];
}
class WatchCachedSchoolsEvent extends SchoolInfoEvent {}
