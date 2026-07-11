import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/network.dart';
import 'package:school/features/BulletinScreen/data/dataSources/RemotedataSource.dart';
import 'package:school/features/BulletinScreen/data/dataSources/cachedataSource.dart';
import 'package:school/features/BulletinScreen/domain/Entities/BulletinEntity.dart';
import 'package:school/features/BulletinScreen/domain/Repo/Bulletin_repo.dart';

class Bulletinrepoimp implements BulletinRepo {
  final RemotedataSource remote;
  final Cachedatasource cache;
  final NetworkInfo networkInfo;

  Bulletinrepoimp({
    required this.remote,
    required this.cache,
    required this.networkInfo,
  });
  @override
  Future<Either<Failures, List<BulletinEntity>>> getBulletins() async {
    try {
      final cached = await cache.getCachedBulletins();
      return Right(cached.map((e) => e.toEntity()).toList());
    } on EmptyCacheExp {
      return await _fetchFromNetworkAndCache();
    }
  }

  @override
  Future<Either<Failures, List<BulletinEntity>>> getBulletinsWithCache() async {
    if (await networkInfo.isConnected) {
      return await _fetchFromNetworkAndCache();
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Stream<List<BulletinEntity>> watchCachedBulletins() {
    return cache.watchCachedBulletins().map(
      (models) => models.map((e) => e.toEntity()).toList(),
    );
  }

  Future<Either<Failures, List<BulletinEntity>>>
  _fetchFromNetworkAndCache() async {
    try {
      final remoted = await remote.getBulletins();
      await cache.cacheBulletins(remoted);
      return Right(remoted.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
