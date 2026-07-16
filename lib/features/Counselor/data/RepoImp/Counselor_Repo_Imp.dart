import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/network.dart';
import 'package:school/features/Counselor/data/DataSources/Grade/cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/Grade/remotdatasource.dart';
import 'package:school/features/Counselor/data/DataSources/StudentList/Cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/StudentList/RemotedataSource.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';

class CounselorRepoImp implements CounselorRepo {
  final RemotdatasourceGrade remote;
  final CachedatasourceGrade cache;
  final NetworkInfo networkInfo;
  final RemotedatasourceStudentList remotedatasourceStudentList;
  final CachedatasourceStudentList cachedatasourceStudentList;
  CounselorRepoImp({
    required this.remote,
    required this.cache,
    required this.networkInfo,
    required this.remotedatasourceStudentList,
    required this.cachedatasourceStudentList,
  });
  @override
  Future<Either<Failures, List<Gradeentity>>> getGradeAndSection() async {
    try {
      final cached = await cache.getCachedgrades();
      return Right(cached.map((e) => e.toEntity()).toList());
    } on EmptyCacheExp {
      return await _fetchFromNetworkAndCache();
    }
  }

  @override
  Future<Either<Failures, List<Gradeentity>>>
  getGradeAndSectionWithCache() async {
    if (await networkInfo.isConnected) {
      return await _fetchFromNetworkAndCache();
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, StudentsBySectionEntity>> getStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    try {
      final cached = await cachedatasourceStudentList
          .getCachedStudentsBySection();
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      return await _fetchFromNetworkAndCacheStudentsBySection(
        localGradeNumber,
        localSectionNumber,
      );
    }
  }

  @override
  Future<Either<Failures, StudentsBySectionEntity>>
  getStudentsBySectionWithCache(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    if (await networkInfo.isConnected) {
      return await _fetchFromNetworkAndCacheStudentsBySection(
        localGradeNumber,
        localSectionNumber,
      );
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Stream<List<Gradeentity>> watchCachedgetGradeAndSection() {
    return cache.watchCachedgrades().map(
      (models) => models.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  Stream<StudentsBySectionEntity> watchCachedgetStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  ) {
    return cachedatasourceStudentList.watchCachedStudentsBySection().map(
      (model) => model.toEntity(),
    );
  }

  Future<Either<Failures, List<Gradeentity>>>
  _fetchFromNetworkAndCache() async {
    try {
      final remoted = await remote.getGardeAndSection();
      await cache.cachegrades(remoted);
      return Right(remoted.map((e) => e.toEntity()).toList());
    } catch (e) {
      print("❌ Error in _fetchFromNetworkAndCache: $e");

      return Left(ServerFailure());
    }
  }

  Future<Either<Failures, StudentsBySectionEntity>>
  _fetchFromNetworkAndCacheStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    try {
      final remoted = await remotedatasourceStudentList.getStudentsBySection(
        localGradeNumber,
        localSectionNumber,
      );
      await cachedatasourceStudentList.cacheStudentsBySection(remoted);
      return Right(remoted.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
