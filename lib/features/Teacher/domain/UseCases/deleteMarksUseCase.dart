import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

class Deletemarksusecase {
  final Teacherrepo repository;

  Deletemarksusecase({required this.repository});

  Future<Either<Failures, Unit>> call(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
  ) async {
    return await repository.deleteMarks(
      schoolId,
      localStudentNumber,
      localSubjectId,
      semester,
      quizTypeId,
    );
  }
}
