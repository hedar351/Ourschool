import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

class Addmarksusecase {
  final Teacherrepo repository;

  Addmarksusecase({required this.repository});

  Future<Either<Failures, Unit>> call(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
    double score,
    double maxScore,
  ) async {
    return await repository.addMarks(
      schoolId,
      localStudentNumber,
      localSubjectId,
      semester,
      quizTypeId,
      score,
      maxScore,
    );
  }
}
