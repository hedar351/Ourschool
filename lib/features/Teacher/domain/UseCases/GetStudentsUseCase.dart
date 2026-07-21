import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

class Getstudentsusecase {
  final Teacherrepo repository;

  Getstudentsusecase({required this.repository});

  Future<Either<Failures, StudentsBySectionEntity>> call(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
  ) async {
    return await repository.getStudents(
      localGradeNumber,
      localSectionNumber,
      localSubjectId,
    );
  }
}
