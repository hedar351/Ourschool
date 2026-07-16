import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';

class StudentBySectionUseCase {
  final CounselorRepo repository;

  StudentBySectionUseCase({required this.repository});

  Future<Either<Failures, StudentsBySectionEntity>> call() async {
    return await repository.getStudentsBySection();
  }
}
