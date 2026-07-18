import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';

class Postwarningsusecase {
  final CounselorRepo repository;

  Postwarningsusecase({required this.repository}) {
    print("🟢 [Postwarningsusecase] Constructor called");
  }

  Future<Either<Failures, CounselorWarningsentity>> call(
    int localStudentNumber,
    String type,
    String reason,
  ) async {
    return await repository.postWarnings(localStudentNumber, type, reason);
  }
}
