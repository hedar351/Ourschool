import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/BulletinScreen/domain/Entities/BulletinEntity.dart';
import 'package:school/features/BulletinScreen/domain/Repo/Bulletin_repo.dart';

class GetbulletinsUseCase {
  BulletinRepo bulletinRepo;
  GetbulletinsUseCase({required this.bulletinRepo});

  Future<Either<Failures, List<BulletinEntity>>> call() async {
    return await bulletinRepo.getBulletins();
  }
}
