// lib/features/Student/data/model/Student-FullProfile/ActivitiesModel.dart

import 'package:hive/hive.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/ActivitiesEntity.dart';

part 'ActivitiesModel.g.dart';

@HiveType(typeId: 23)
class ActivitiesModel extends HiveObject {
  @HiveField(0)
  final String? activityName;

  @HiveField(1)
  final String? status;

  @HiveField(2)
  final String? date;

  ActivitiesModel({
    required this.activityName,
    required this.status,
    required this.date,
  });

  // ----- fromEntity -----
  factory ActivitiesModel.fromEntity(ActivitiesEntity entity) {
    return ActivitiesModel(
      activityName: entity.activityName,
      status: entity.status,
      date: entity.date,
    );
  }

  // ----- fromJson -----
  factory ActivitiesModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesModel(
      activityName: json['activityName'] as String?,
      status: json['status'] as String?,
      date: json['createdAt'] as String?, // JSON يستخدم createdAt
    );
  }

  // ----- toEntity -----
  ActivitiesEntity toEntity() {
    return ActivitiesEntity(
      activityName: activityName,
      status: status,
      date: date,
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {'activityName': activityName, 'status': status, 'date': date};
  }
}
