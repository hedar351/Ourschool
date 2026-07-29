import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentFullProfileEntity.dart';

abstract class StudentRepo {
  Future<Either<Failures, List<Studentfullprofileentity>>> getFullprofile();
  Future<Either<Failures, List<Studentfullprofileentity>>>
  getFullprofileWithCached();
  Stream<Either<Failures, List<Studentfullprofileentity>>>
  watchStudentProfile();
}
