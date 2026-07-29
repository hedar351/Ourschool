// lib/features/Student/data/model/Student-FullProfile/StatisticsModel.dart

import 'package:hive/hive.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StatisticsEntity.dart';

part 'StatisticsModel.g.dart';

@HiveType(typeId: 22)
class StatisticsModel extends HiveObject {
  @HiveField(0)
  final int? totalAttendance;

  @HiveField(1)
  final int? totalActivities;

  @HiveField(2)
  final int? totalWarnings;

  StatisticsModel({
    required this.totalAttendance,
    required this.totalActivities,
    required this.totalWarnings,
  });

  // ----- fromEntity -----
  factory StatisticsModel.fromEntity(StatisticsEntity entity) {
    return StatisticsModel(
      totalAttendance: entity.totalAttendance,
      totalActivities: entity.totalActivities,
      totalWarnings: entity.totalWarnings,
    );
  }

  // ----- fromJson -----
  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      totalAttendance: json['totalAttendance'] as int?,
      totalActivities: json['totalActivities'] as int?,
      totalWarnings: json['totalWarnings'] as int?,
    );
  }

  // ----- toEntity -----
  StatisticsEntity toEntity() {
    return StatisticsEntity(
      totalAttendance: totalAttendance,
      totalActivities: totalActivities,
      totalWarnings: totalWarnings,
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'totalAttendance': totalAttendance,
      'totalActivities': totalActivities,
      'totalWarnings': totalWarnings,
    };
  }
}
