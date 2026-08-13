import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/services/network.dart';
import 'package:school/features/FirstStep/SchoolsInfo/domain/Entities/SchoolWithTeacherEntity.dart';

import '../../domain/Repo/SchoolRepository.dart';
import '../DataSource/SchoolCacheDataSource.dart';
import '../DataSource/SchoolRemoteDataSource.dart';

class SchoolRepositoryImpl implements SchoolRepository {
  final SchoolRemoteDataSource remote;
  final SchoolCacheDataSource cache;
  final NetworkInfo networkInfo;

  SchoolRepositoryImpl({
    required this.remote,
    required this.cache,
    required this.networkInfo,
  });
  @override
  Future<Either<Failures, Schoolwithteacherentity>>
  getSchoolwithteachere() async {
    try {
      final cached = await cache.getCachedSchools();
      print(' [Repository] Using cached public schools');
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      print(' [Repository] Cache empty, fetching from network');
      return await _fetchFromNetworkAndCache();
    } catch (e) {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failures, Schoolwithteacherentity>>
  getSchoolwithteachereWithCached() async {
    if (await networkInfo.isConnected) {
      print(' [Repository] Force refresh from network');
      return await _fetchFromNetworkAndCache();
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Stream<Schoolwithteacherentity> watchCachedSchoolwithteachere() {
    return cache.watchCachedSchools().map((model) {
      print(' [Repository] Cache updated, notifying UI');
      return model.toEntity();
    });
  }

  Future<Either<Failures, Schoolwithteacherentity>>
  _fetchFromNetworkAndCache() async {
    try {
      final remoteData = await remote.getSchoolsWithTeachers();
      print(
        ' [Repository] Fetched ${remoteData.schoolInfo?.length ?? 0} schools from API',
      );
      await cache.cacheSchools(remoteData);
      print(' [Repository] Saved to cache');

      return Right(remoteData.toEntity());
    } catch (e) {
      print(' [Repository] Error: $e');
      return Left(ServerFailure());
    }
  }
}
