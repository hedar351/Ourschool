import 'package:equatable/equatable.dart';

class MarksStatisticsEntity extends Equatable {
  final int? totalMarks;
  final int? passedSubjects;
  final int? failedSubjects;
  final int? successRate;
  final int? semester1Count;
  final int? semester2Count;
  final int? semester1Average;
  final int? semester2Average;
  final int? finalAverage;

  const MarksStatisticsEntity({
    required this.totalMarks,
    required this.passedSubjects,
    required this.failedSubjects,
    required this.successRate,
    required this.semester1Count,
    required this.semester2Count,
    required this.semester1Average,
    required this.semester2Average,
    required this.finalAverage,
  });

  @override
  List<Object?> get props => [
    totalMarks,
    passedSubjects,
    failedSubjects,
    successRate,
    semester1Count,
    semester2Count,
    semester1Average,
    semester2Average,
    finalAverage,
  ];
}
