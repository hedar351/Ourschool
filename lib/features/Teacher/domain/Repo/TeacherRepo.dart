// import 'package:dartz/dartz.dart';
// import 'package:school/core/error/failures.dart';
// import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
// import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';
// import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';

// abstract class Teacherrepo {
//   Future<Either<Failures, StudentsBySectionEntity>> getStudents(
//     int localGradeNumber,
//     int localSectionNumber,
//     int localSubjectId,
//     int schoolId,
//   );
//   Future<Either<Failures, StudentsBySectionEntity>> getStudentsWithCache(
//     int localGradeNumber,
//     int localSectionNumber,
//     int localSubjectId,
//     int schoolId,
//   );
//   Future<Either<Failures, TeacherFullprofileentity>> getTeacherFullprofile();

//   Future<Either<Failures, TeacherFullprofileentity>>
//   getTeacherFullprofileWithCache();
//   Future<Either<Failures, Teacherstudentprofileentity>>
//   getTeacherStudentsProfile(int localStudentNumber, int schoolId);
//   Future<Either<Failures, Teacherstudentprofileentity>>
//   getTeacherStudentsProfileWithCached(int localStudentNumber, int schoolId);

//   Stream<StudentsBySectionEntity> watchCachedgetStudents(
//     int localGradeNumber,
//     int localSectionNumber,
//     int localSubjectId,
//     int schoolId,
//   );
//   Stream<TeacherFullprofileentity> watchCachedgetTeacherFullprofile();
//   Stream<Teacherstudentprofileentity> watchCacheTeacherStudentsProfile(
//     int localStudentNumber,
//     int schoolId,
//   );
// }
// lib/features/Teacher/domain/Repo/TeacherRepo.dart

import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';

// ======================================================================
// ====== TEACHER REPOSITORY ======
// ======================================================================

abstract class Teacherrepo {
  // ====================================================================
  // ====== 1. STUDENTS BY SECTION & SUBJECT ======
  // ====================================================================

  /// جلب الطلاب حسب الصف، الشعبة، المادة، والمدرسة
  Future<Either<Failures, StudentsBySectionEntity>> getStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  );

  /// جلب الطلاب مع التحديث من الشبكة (تجاوز الكاش)
  Future<Either<Failures, StudentsBySectionEntity>> getStudentsWithCache(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  );

  /// جلب الملف الشخصي الكامل للمعلم
  Future<Either<Failures, TeacherFullprofileentity>> getTeacherFullprofile();

  // ====================================================================
  // ====== 2. TEACHER FULL PROFILE ======
  // ====================================================================

  /// جلب الملف الشخصي للمعلم مع التحديث من الشبكة
  Future<Either<Failures, TeacherFullprofileentity>>
  getTeacherFullprofileWithCache();

  /// جلب ملف طالب محدد من وجهة نظر المعلم
  Future<Either<Failures, Teacherstudentprofileentity>>
  getTeacherStudentsProfile(int localStudentNumber, int schoolId);

  /// جلب ملف طالب مع التحديث من الشبكة
  Future<Either<Failures, Teacherstudentprofileentity>>
  getTeacherStudentsProfileWithCached(int localStudentNumber, int schoolId);

  // ====================================================================
  // ====== 3. TEACHER STUDENT PROFILE ======
  // ====================================================================

  /// مراقبة التغييرات في كاش الطلاب (تحديث حي)
  Stream<StudentsBySectionEntity> watchCachedgetStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  );

  /// مراقبة التغييرات في كاش الملف الشخصي للمعلم
  Stream<TeacherFullprofileentity> watchCachedgetTeacherFullprofile();

  /// مراقبة التغييرات في كاش ملف الطالب
  Stream<Teacherstudentprofileentity> watchCacheTeacherStudentsProfile(
    int localStudentNumber,
    int schoolId,
  );
}
