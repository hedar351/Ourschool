
import 'package:hive/hive.dart';
import 'package:school/features/Activities/data/model/activities_statistics_model.dart';
import 'package:school/features/Activities/data/model/registrations_info_model.dart';
import 'package:school/features/Activities/domain/entity/activities_registrations_entity.dart';
import 'package:school/features/Activities/domain/entity/activities_statistics_entity.dart';

part 'activities_registrations_model.g.dart';

@HiveType(typeId: 42)
class ActivitiesRegistrationsModel extends HiveObject {
  @HiveField(0)
  final ActivitiesStatisticsModel? statistics;

  @HiveField(1)
  final List<RegistrationsInfoModel>? registrations;

  ActivitiesRegistrationsModel({
    required this.statistics,
    required this.registrations,
  });

  // ----- fromEntity -----
  factory ActivitiesRegistrationsModel.fromEntity(
    ActivitiesRegistrationsEntity entity,
  ) {
    return ActivitiesRegistrationsModel(
      statistics: ActivitiesStatisticsModel.fromEntity(
        entity.activitiesStatisticsEntity,
      ),
      registrations: entity.registrationsInfoEntity
          .map((e) => RegistrationsInfoModel.fromEntity(e))
          .toList(),
    );
  }

  // ----- fromJson -----
  factory ActivitiesRegistrationsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return ActivitiesRegistrationsModel(
      statistics: data['statistics'] != null
          ? ActivitiesStatisticsModel.fromJson(
              data['statistics'] as Map<String, dynamic>,
            )
          : null,
      registrations: (data['registrations'] as List? ?? [])
          .map(
            (e) => RegistrationsInfoModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  // ----- toEntity -----
  ActivitiesRegistrationsEntity toEntity() {
    return ActivitiesRegistrationsEntity(
      activitiesStatisticsEntity:
          statistics?.toEntity() ??
          const ActivitiesStatisticsEntity(
            total: 0,
            pending: 0,
            approved: 0,
            rejected: 0,
          ),
      registrationsInfoEntity:
          registrations?.map((e) => e.toEntity()).toList() ?? [],
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'statistics': statistics?.toJson(),
        'registrations': registrations?.map((e) => e.toJson()).toList(),
      },
    };
  }
}
