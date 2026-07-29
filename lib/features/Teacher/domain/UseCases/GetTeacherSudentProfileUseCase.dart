import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

class Getteachersudentprofileusecase {
  final Teacherrepo repository;

  Getteachersudentprofileusecase({required this.repository});
  Future<Either<Failures, Teacherstudentprofileentity>> call(
    int localStudentNumber,

    int schoolId,
  ) async {
    return await repository.getTeacherStudentsProfile(
      localStudentNumber,
      schoolId,
    );
  }
}
