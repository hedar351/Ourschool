import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_studentFullProfile.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/features/Counselor/domain/Entities/scheduleImageEntity/GetscheduleImageEntity.dart';

abstract class CounselorRepo {
  Future<Either<Failures, Unit>> addAttendance(
    int localStudentNumber,
    String date,
  );
  Future<Either<Failures, Unit>> deleteAttendance(
    int localStudentNumber,
    String date,
  );
  // Student Full Profile
  Future<Either<Failures, CounselorStudentfullprofile>>
  getCounselorStudentfullProfile(int localStudentNumber);

  Future<Either<Failures, CounselorStudentfullprofile>>
  getCounselorStudentfullProfileWithCache(int localStudentNumber);

  // Grade & Section
  Future<Either<Failures, List<Gradeentity>>> getGradeAndSection();
  Future<Either<Failures, List<Gradeentity>>> getGradeAndSectionWithCache();
  Future<Either<Failures, Getscheduleimageentity>> getscheduleImage(
    int localGradeNumber,
    int localSectionNumber,
  );

  // Students by Section
  Future<Either<Failures, StudentsBySectionEntity>> getStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  );
  Future<Either<Failures, StudentsBySectionEntity>>
  getStudentsBySectionWithCache(int localGradeNumber, int localSectionNumber);

  // image
  // Future<Either<Failures, PostscheduleImageEntity>> postscheduleImage(
  //   int localGradeNumber,
  //   int localSectionNumber,
  //   String image,
  // );

  // Actions
  Future<Either<Failures, CounselorWarningsentity>> postWarnings(
    int localStudentNumber,
    String type,
    String reason,
  );
  //Stream
  Stream<CounselorStudentfullprofile> watchCachedgetCounselorStudentfullProfile(
    int localStudentNumber,
  );

  Stream<List<Gradeentity>> watchCachedgetGradeAndSection();

  Stream<StudentsBySectionEntity> watchCachedgetStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  );
}
