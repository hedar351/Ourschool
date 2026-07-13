import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';

class GradeAndSectionUseCase {
  final CounselorRepo repository;

  GradeAndSectionUseCase({required this.repository});

  Future<Either<Failures, List<Gradeentity>>> call() async {
    return await repository.getGradeAndSection();
  }
}
