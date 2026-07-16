part of 'grade_bloc.dart';

class GetGradeEvent extends GradeEvent {}

sealed class GradeEvent extends Equatable {
  const GradeEvent();

  @override
  List<Object> get props => [];
}

class RefreshGradeEvent extends GradeEvent {}

class RevalidateGradeEvent extends GradeEvent {}

class UpdateCachedGradeEvent extends GradeEvent {
  final List<Gradeentity> grade;
  const UpdateCachedGradeEvent({required this.grade});
  @override
  List<Object> get props => [grade];
}

class WatchCachedGradeEvent extends GradeEvent {}
