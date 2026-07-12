import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/BulletinScreen/data/model/BulletinModel.dart';

abstract class Cachedatasource {
  Future<Unit> cacheBulletins(List<Bulletinmodel> bulletins);
  Future<List<Bulletinmodel>> getCachedBulletins();
  Stream<List<Bulletinmodel>> watchCachedBulletins();
}

class CacheDataSourceImp implements Cachedatasource {
  final Box<Bulletinmodel> box;

  CacheDataSourceImp({required this.box});

  @override
  Future<Unit> cacheBulletins(List<Bulletinmodel> bulletins) async {
    await box.clear();
    await box.addAll(bulletins);
    return unit;
  }

  @override
  Future<List<Bulletinmodel>> getCachedBulletins() async {
    if (box.isEmpty) {
      throw EmptyCacheExp();
    }
    return box.values.toList();
  }

  @override
  Stream<List<Bulletinmodel>> watchCachedBulletins() {
    return box.watch().map((event) => box.values.toList());
  }
}
