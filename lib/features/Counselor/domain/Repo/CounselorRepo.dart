import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_studentFullProfile.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';

abstract class CounselorRepo {
  Future<Either<Failures, CounselorStudentfullprofile>>
  getCounselorStudentfullProfile(int localStudentNumber);

  Future<Either<Failures, CounselorStudentfullprofile>>
  getCounselorStudentfullProfileWithCache(int localStudentNumber);

  // Future<Either<Failures, List<Attendanceentity>>> attendance();
  Future<Either<Failures, List<Gradeentity>>> getGradeAndSection();

  Future<Either<Failures, List<Gradeentity>>> getGradeAndSectionWithCache();

  Future<Either<Failures, StudentsBySectionEntity>> getStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  );
  Future<Either<Failures, StudentsBySectionEntity>>
  getStudentsBySectionWithCache(int localGradeNumber, int localSectionNumber);

  Stream<CounselorStudentfullprofile> watchCachedgetCounselorStudentfullProfile(
    int localStudentNumber,
  );
  Stream<List<Gradeentity>> watchCachedgetGradeAndSection();
  Stream<StudentsBySectionEntity> watchCachedgetStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  );
}
