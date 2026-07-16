import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';

abstract class CounselorRepo {
  // Future<Either<Failures, List<Attendanceentity>>> attendance();
  Future<Either<Failures, List<Gradeentity>>> getGradeAndSection();

  Future<Either<Failures, List<Gradeentity>>> getGradeAndSectionWithCache();

  Future<Either<Failures, StudentsBySectionEntity>> getStudentsBySection();

  Future<Either<Failures, StudentsBySectionEntity>>
  getStudentsBySectionWithCache();

  Stream<List<Gradeentity>> watchCachedgetGradeAndSection();
  Stream<StudentsBySectionEntity> watchCachedgetStudentsBySection();
}
