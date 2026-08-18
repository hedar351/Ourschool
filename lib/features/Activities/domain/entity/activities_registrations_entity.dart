import 'package:equatable/equatable.dart';
import 'package:school/features/Activities/domain/entity/activities_statistics_entity.dart';
import 'package:school/features/Activities/domain/entity/registrations_info_entity.dart';

class ActivitiesRegistrationsEntity extends Equatable {
  final ActivitiesStatisticsEntity activitiesStatisticsEntity;
  final List<RegistrationsInfoEntity> registrationsInfoEntity;

  const ActivitiesRegistrationsEntity({
    required this.activitiesStatisticsEntity,
    required this.registrationsInfoEntity,
  });
  @override
  List<Object?> get props => [
    activitiesStatisticsEntity,
    registrationsInfoEntity,
  ];
}
