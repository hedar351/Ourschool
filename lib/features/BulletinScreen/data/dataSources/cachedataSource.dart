import 'package:dartz/dartz.dart';
import 'package:school/features/BulletinScreen/data/model/BulletinModel.dart';

abstract class Cachedatasource {
  Future<Unit> cacheBulletins(List<Bulletinmodel> bulletins);
  Future<List<Bulletinmodel>> getCachedBulletins();
  Stream<List<Bulletinmodel>> watchCachedBulletins();
}

class CacheDataSourceImp implements Cachedatasource {
  @override
  Future<Unit> cacheBulletins(List<Bulletinmodel> bulletins) {
    throw UnimplementedError();
  }

  @override
  Future<List<Bulletinmodel>> getCachedBulletins() {
    throw UnimplementedError();
  }

  @override
  Stream<List<Bulletinmodel>> watchCachedBulletins() {
    throw UnimplementedError();
  }
}
