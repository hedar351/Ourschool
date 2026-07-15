import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/network.dart';
import 'package:school/features/Counselor/data/DataSources/cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/remotdatasource.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';

class CounselorRepoImp implements CounselorRepo {
  final RemotdatasourceGrade remote;
  final CachedatasourceGrade cache;
  final NetworkInfo networkInfo;

  CounselorRepoImp({
    required this.remote,
    required this.cache,
    required this.networkInfo,
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
  Stream<List<Gradeentity>> watchCachedgetGradeAndSection() {
    return cache.watchCachedgrades().map(
      (models) => models.map((e) => e.toEntity()).toList(),
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
}
