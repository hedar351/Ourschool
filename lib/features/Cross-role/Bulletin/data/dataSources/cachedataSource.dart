import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Cross-role/Bulletin/data/model/BulletinModel.dart';

abstract class CachedatasourceBulletin {
  Future<Unit> cacheBulletins(List<Bulletinmodel> bulletins);
  Future<Unit> deleteBulletins();
  Future<List<Bulletinmodel>> getCachedBulletins();
  Stream<List<Bulletinmodel>> watchCachedBulletins();
}

class CacheDataSourceImpBulletin implements CachedatasourceBulletin {
  final Box<Bulletinmodel> box;

  CacheDataSourceImpBulletin({required this.box});

  @override
  Future<Unit> cacheBulletins(List<Bulletinmodel> bulletins) async {
    await box.clear();
    await box.addAll(bulletins);
    return unit;
  }

  @override
  Future<Unit> deleteBulletins() async {
    await box.clear();
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
