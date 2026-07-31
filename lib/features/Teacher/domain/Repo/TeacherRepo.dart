import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';

// ======================================================================
// ====== TEACHER REPOSITORY ======
// ======================================================================

abstract class Teacherrepo {
  Future<Either<Failures, Unit>> addMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
    double score,
    double maxScore,
  );
  Future<Either<Failures, Unit>> deleteMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
  );

  Future<Either<Failures, Unit>> editMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
    double score,
    double maxScore,
  );

  // ====================================================================
  // ====== 1. STUDENTS BY SECTION & SUBJECT ======
  // ====================================================================

  Future<Either<Failures, StudentsBySectionEntity>> getStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  );

  Future<Either<Failures, StudentsBySectionEntity>> getStudentsWithCache(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  );

  Future<Either<Failures, TeacherFullprofileentity>> getTeacherFullprofile();

  // ====================================================================
  // ====== 2. TEACHER FULL PROFILE ======
  // ====================================================================

  Future<Either<Failures, TeacherFullprofileentity>>
  getTeacherFullprofileWithCache();

  Future<Either<Failures, Teacherstudentprofileentity>>
  getTeacherStudentsProfile(int localStudentNumber, int schoolId);

  Future<Either<Failures, Teacherstudentprofileentity>>
  getTeacherStudentsProfileWithCached(int localStudentNumber, int schoolId);

  // ====================================================================
  // ====== 3. TEACHER STUDENT PROFILE ======
  // ====================================================================

  Stream<StudentsBySectionEntity> watchCachedgetStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  );
  Stream<TeacherFullprofileentity> watchCachedgetTeacherFullprofile();
  Stream<Teacherstudentprofileentity> watchCacheTeacherStudentsProfile(
    int localStudentNumber,
    int schoolId,
  );
}
