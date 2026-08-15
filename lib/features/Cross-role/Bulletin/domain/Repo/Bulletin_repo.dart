import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Cross-role/Bulletin/domain/Entities/BulletinEntity.dart';

abstract class BulletinRepo {
  Future<Either<Failures, List<BulletinEntity>>> getBulletins();
  Future<Either<Failures, List<BulletinEntity>>> getBulletinsWithCache();
  Stream<List<BulletinEntity>> watchCachedBulletins();
}
