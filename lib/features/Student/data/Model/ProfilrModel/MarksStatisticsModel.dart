import 'package:hive/hive.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/MarksStatisticsEntity.dart';

part 'MarksStatisticsModel.g.dart';

@HiveType(typeId: 39)
class MarksStatisticsModel extends HiveObject {
  @HiveField(0)
  final int? totalMarks;

  @HiveField(1)
  final int? passedSubjects;

  @HiveField(2)
  final int? failedSubjects;

  @HiveField(3)
  final int? successRate;

  @HiveField(4)
  final int? semester1Count;

  @HiveField(5)
  final int? semester2Count;

  @HiveField(6)
  final double? semester1Average;

  @HiveField(7)
  final double? semester2Average;

  @HiveField(8)
  final double? finalAverage;

  MarksStatisticsModel({
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

  factory MarksStatisticsModel.fromEntity(MarksStatisticsEntity entity) {
    return MarksStatisticsModel(
      totalMarks: entity.totalMarks,
      passedSubjects: entity.passedSubjects,
      failedSubjects: entity.failedSubjects,
      successRate: entity.successRate,
      semester1Count: entity.semester1Count,
      semester2Count: entity.semester2Count,
      semester1Average: entity.semester1Average?.toDouble(),
      semester2Average: entity.semester2Average?.toDouble(),
      finalAverage: entity.finalAverage?.toDouble(),
    );
  }

  factory MarksStatisticsModel.fromJson(Map<String, dynamic> json) {
    return MarksStatisticsModel(
      totalMarks: json['totalMarks'] as int?,
      passedSubjects: json['passedSubjects'] as int?,
      failedSubjects: json['failedSubjects'] as int?,
      successRate: json['successRate'] as int?,
      semester1Count: json['semester1Count'] as int?,
      semester2Count: json['semester2Count'] as int?,
      semester1Average: (json['semester1Average'] as num?)?.toDouble(),
      semester2Average: (json['semester2Average'] as num?)?.toDouble(),
      finalAverage: (json['finalAverage'] as num?)?.toDouble(),
    );
  }

  MarksStatisticsEntity toEntity() {
    return MarksStatisticsEntity(
      totalMarks: totalMarks,
      passedSubjects: passedSubjects,
      failedSubjects: failedSubjects,
      successRate: successRate,
      semester1Count: semester1Count,
      semester2Count: semester2Count,
      semester1Average: semester1Average?.toInt(),
      semester2Average: semester2Average?.toInt(),
      finalAverage: finalAverage?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalMarks': totalMarks,
      'passedSubjects': passedSubjects,
      'failedSubjects': failedSubjects,
      'successRate': successRate,
      'semester1Count': semester1Count,
      'semester2Count': semester2Count,
      'semester1Average': semester1Average,
      'semester2Average': semester2Average,
      'finalAverage': finalAverage,
    };
  }
}
