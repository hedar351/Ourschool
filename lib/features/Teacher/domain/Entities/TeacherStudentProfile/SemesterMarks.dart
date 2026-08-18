import 'package:equatable/equatable.dart';

class SemesterMarks extends Equatable {
  final int? localSubjectId;
  final String? subjectName;
  final double? oral;
  final double? maxOral;
  final double? quiz1;
  final double? maxQuiz1;
  final double? quiz2;
  final double? maxQuiz2;
  final double? homework;
  final double? maxHomework;
  final double? finalExam;
  final double? maxFinalExam;
  final double? total;

  const SemesterMarks({
    required this.localSubjectId,
    required this.subjectName,
    required this.oral,
    required this.maxOral,
    required this.quiz1,
    required this.maxQuiz1,
    required this.quiz2,
    required this.maxQuiz2,
    required this.homework,
    required this.maxHomework,
    required this.finalExam,
    required this.maxFinalExam,
    required this.total,
  });
  @override
  List<Object?> get props => [
    localSubjectId,
    subjectName,
    oral,
    maxOral,
    quiz1,
    maxQuiz1,
    quiz2,
    maxQuiz2,
    homework,
    maxHomework,
    finalExam,
    maxFinalExam,
    total,
  ];
}
