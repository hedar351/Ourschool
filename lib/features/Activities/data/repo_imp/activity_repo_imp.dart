import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/services/network.dart';
import 'package:school/features/Activities/data/data_source/activities_registrations_cache_data_source.dart';
import 'package:school/features/Activities/data/data_source/activities_registrations_remote_data_source.dart';
import 'package:school/features/Activities/data/data_source/activities_remote_data.dart';
import 'package:school/features/Activities/domain/entity/activities_registrations_entity.dart';
import 'package:school/features/Activities/domain/entity/activities_statistics_entity.dart';
import 'package:school/features/Activities/domain/repo/activites_repo.dart';

class ActivityRepoImp implements ActivitesRepo {
  final ActivitiesRemoteData activitiesRemoteData;
  final NetworkInfo networkInfo;
  final ActivitiesRegistrationsRemoteDataSource remote;
  final ActivitiesRegistrationsCacheDataSource cache;
  ActivityRepoImp({
    required this.activitiesRemoteData,
    required this.networkInfo,
    required this.remote,
    required this.cache,
  });

  @override
  Future<Either<Failures, Unit>> addActivities(
    String title,
    String description,
    String expiryDate,
  ) async {
    print('[Repo] addActivities() - إضافة نشاط جديد');
    print(
      '[Repo] العنوان: $title, الوصف: $description, تاريخ الانتهاء: $expiryDate',
    );

    if (!await networkInfo.isConnected) {
      print('🔴 [Repo] لا يوجد اتصال بالإنترنت');
      return Left(OfflineFailure());
    }

    try {
      await activitiesRemoteData.addActivities(title, description, expiryDate);
      print(' [Repo] تم إضافة النشاط بنجاح');
      return const Right(unit);
    } catch (e) {
      print('🔴 [Repo] فشل إضافة النشاط: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, Unit>> deleteActivities(int localActivityId) async {
    print('[Repo] deleteActivities() - حذف النشاط رقم $localActivityId');

    if (!await networkInfo.isConnected) {
      print('🔴 [Repo] لا يوجد اتصال بالإنترنت');
      return Left(OfflineFailure());
    }

    try {
      await activitiesRemoteData.deleteActivities(localActivityId);
      print(' [Repo] تم حذف النشاط بنجاح');
      return const Right(unit);
    } catch (e) {
      print('🔴 [Repo] فشل حذف النشاط: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, Unit>> editActivities(
    int localActivityId,
    String title,
    String description,
    String expiryDate,
  ) async {
    print('[Repo] editActivities() - تعديل النشاط رقم $localActivityId');
    print(
      '[Repo] العنوان: $title, الوصف: $description, تاريخ الانتهاء: $expiryDate',
    );

    if (!await networkInfo.isConnected) {
      print('🔴 [Repo] لا يوجد اتصال بالإنترنت');
      return Left(OfflineFailure());
    }

    try {
      await activitiesRemoteData.editActivities(
        localActivityId,
        title,
        description,
        expiryDate,
      );
      print(' [Repo] تم تعديل النشاط بنجاح');
      return const Right(unit);
    } catch (e) {
      print('🔴 [Repo] فشل تعديل النشاط: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, ActivitiesRegistrationsEntity>>
  getActivitieRegistration(int id) async {
    try {
      final cached = await cache.getCachedActivitiesRegistrations(id);
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      return await _fetchFromNetworkAndCache(id);
    }
  }

  @override
  Future<Either<Failures, ActivitiesRegistrationsEntity>>
  getActivitieRegistrationWithCache(int id) async {
    if (await networkInfo.isConnected) {
      return await _fetchFromNetworkAndCache(id);
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Stream<ActivitiesRegistrationsEntity> watchCachedActivitieRegistration(
    int id,
  ) {
    return cache
        .watchCachedActivitiesRegistrations(id)
        .map((model) => model?.toEntity() ?? _emptyRegistrationsEntity());
  }

  ActivitiesRegistrationsEntity _emptyRegistrationsEntity() {
    return ActivitiesRegistrationsEntity(
      activitiesStatisticsEntity: const ActivitiesStatisticsEntity(
        total: 0,
        pending: 0,
        approved: 0,
        rejected: 0,
      ),
      registrationsInfoEntity: [],
    );
  }

  Future<Either<Failures, ActivitiesRegistrationsEntity>>
  _fetchFromNetworkAndCache(int id) async {
    try {
      final remoteData = await remote.getActivitiesRegistrations(id);
      await cache.cacheActivitiesRegistrations(remoteData, id);
      return Right(remoteData.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
