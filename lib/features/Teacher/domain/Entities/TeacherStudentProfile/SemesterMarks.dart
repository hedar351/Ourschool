import 'package:equatable/equatable.dart';

class SemesterMarks extends Equatable {
  final int? localSubjectId;
  final String? subjectName;
  final double? quiz1;
  final double? quiz2;
  final double? homework;
  final double? finalExam;
  final double? total;

  const SemesterMarks({
    required this.localSubjectId,
    required this.subjectName,
    required this.quiz1,
    required this.quiz2,
    required this.homework,
    required this.finalExam,
    required this.total,
  });
  @override
  List<Object?> get props => [
    localSubjectId,
    subjectName,
    quiz1,
    quiz2,
    homework,
    finalExam,
    total,
  ];
}
