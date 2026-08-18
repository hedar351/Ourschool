import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Activities/domain/entity/activities_registrations_entity.dart';
import 'package:school/features/Activities/domain/repo/activites_repo.dart';

class ActivitiesRegistrationsUseCase {
  ActivitesRepo repo;
  ActivitiesRegistrationsUseCase({required this.repo});

  Future<Either<Failures, ActivitiesRegistrationsEntity>> call(int id) async {
    return await repo.getActivitieRegistration(id);
  }
}
