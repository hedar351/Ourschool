import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Activities/domain/entity/activities_registrations_entity.dart';

abstract class ActivitesRepo {
  Future<Either<Failures, Unit>> addActivities(
    String title,
    String description,
    String expiryDate,
  );
  Future<Either<Failures, Unit>> approveRegistrations(
    int id,
    int studentLocalNumber,
  );
  Future<Either<Failures, Unit>> deleteActivities(int localActivityId);

  Future<Either<Failures, Unit>> editActivities(
    int localActivityId,
    String title,
    String description,
    String expiryDate,
  );
  Future<Either<Failures, ActivitiesRegistrationsEntity>>
  getActivitieRegistration(int id);

  Future<Either<Failures, ActivitiesRegistrationsEntity>>
  getActivitieRegistrationWithCache(int id);

  Future<Either<Failures, Unit>> rejectRegistrations(
    int id,
    int studentLocalNumber,
  );

  Stream<ActivitiesRegistrationsEntity> watchCachedActivitieRegistration(
    int id,
  );
}
