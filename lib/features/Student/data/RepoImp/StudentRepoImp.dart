import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Student/domain/Repo/StudentRepo.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentFullProfileEntity.dart';

class Studentrepoimp implements StudentRepo {
  @override
  Future<Either<Failures, List<Studentfullprofileentity>>> getFullprofile() {
    // TODO: implement getFullprofile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<Studentfullprofileentity>>>
  getFullprofileWithCached() {
    // TODO: implement getFullprofileWithCached
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failures, List<Studentfullprofileentity>>>
  watchStudentProfile() {
    // TODO: implement watchStudentProfile
    throw UnimplementedError();
  }
}
