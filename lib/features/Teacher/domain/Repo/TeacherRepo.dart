import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';

abstract class Teacherrepo {
  Future<Either<Failures, StudentsBySectionEntity>> getStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
  );
  Future<Either<Failures, StudentsBySectionEntity>> getStudentsWithCache(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
  );
  Future<Either<Failures, TeacherFullprofileentity>> getTeacherFullprofile();

  Future<Either<Failures, TeacherFullprofileentity>>
  getTeacherFullprofileWithCache();
  Stream<StudentsBySectionEntity> watchCachedgetStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
  );
  Stream<TeacherFullprofileentity> watchCachedgetTeacherFullprofile();
}
