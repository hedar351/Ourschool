import 'package:hive/hive.dart';
import 'package:school/features/Activities/domain/entity/activities_statistics_entity.dart';

part 'activities_statistics_model.g.dart';

@HiveType(typeId: 40)
class ActivitiesStatisticsModel extends HiveObject {
  @HiveField(0)
  final int? total;

  @HiveField(1)
  final int? pending;

  @HiveField(2)
  final int? approved;

  @HiveField(3)
  final int? rejected;

  ActivitiesStatisticsModel({
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
  });

  // ----- fromEntity -----
  factory ActivitiesStatisticsModel.fromEntity(
    ActivitiesStatisticsEntity entity,
  ) {
    return ActivitiesStatisticsModel(
      total: entity.total,
      pending: entity.pending,
      approved: entity.approved,
      rejected: entity.rejected,
    );
  }

  // ----- fromJson -----
  factory ActivitiesStatisticsModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesStatisticsModel(
      total: json['total'] as int?,
      pending: json['pending'] as int?,
      approved: json['approved'] as int?,
      rejected: json['rejected'] as int?,
    );
  }

  // ----- toEntity -----
  ActivitiesStatisticsEntity toEntity() {
    return ActivitiesStatisticsEntity(
      total: total,
      pending: pending,
      approved: approved,
      rejected: rejected,
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'pending': pending,
      'rejected': rejected,
      'approved': approved,
    };
  }
}
