part of 'mark_bloc.dart';

class AddMarkEvent extends MarkEvent {
  final int schoolId;
  final int localStudentNumber;
  final int localSubjectId;
  final int semester;
  final int quizTypeId;
  final double score;
  final double maxScore;

  const AddMarkEvent({
    required this.schoolId,
    required this.localStudentNumber,
    required this.localSubjectId,
    required this.semester,
    required this.quizTypeId,
    required this.score,
    required this.maxScore,
  });
  @override
  List<Object> get props => [
    schoolId,
    localStudentNumber,
    localSubjectId,
    semester,
    quizTypeId,
    score,
    maxScore,
  ];
}

class DeleteEvent extends MarkEvent {
  final int schoolId;
  final int localStudentNumber;
  final int localSubjectId;
  final int semester;
  final int quizTypeId;

  const DeleteEvent({
    required this.schoolId,
    required this.localStudentNumber,
    required this.localSubjectId,
    required this.semester,
    required this.quizTypeId,
  });
  @override
  List<Object> get props => [
    schoolId,
    localStudentNumber,
    localSubjectId,
    semester,
    quizTypeId,
  ];
}

class EditEvent extends MarkEvent {
  final int schoolId;
  final int localStudentNumber;
  final int localSubjectId;
  final int semester;
  final int quizTypeId;
  final double score;
  final double maxScore;

  const EditEvent({
    required this.schoolId,
    required this.localStudentNumber,
    required this.localSubjectId,
    required this.semester,
    required this.quizTypeId,
    required this.score,
    required this.maxScore,
  });
  @override
  List<Object> get props => [
    schoolId,
    localStudentNumber,
    localSubjectId,
    semester,
    quizTypeId,
    score,
    maxScore,
  ];
}

sealed class MarkEvent extends Equatable {
  const MarkEvent();

  @override
  List<Object> get props => [];
}
