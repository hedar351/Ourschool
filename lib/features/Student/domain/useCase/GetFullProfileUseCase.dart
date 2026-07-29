import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Student/domain/Repo/StudentRepo.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentFullProfileEntity.dart';

class Getfullprofileusecase {
  StudentRepo repo;
  Getfullprofileusecase({required this.repo});

  Future<Either<Failures, List<Studentfullprofileentity>>> call() async {
    return await repo.getFullprofile();
  }
}
