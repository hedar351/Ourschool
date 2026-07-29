import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';

class DeleteAttendanceUseCase {
  final CounselorRepo repository;

  DeleteAttendanceUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(
    int localStudentNumber,
    String date,
  ) async {
    return await repository.deleteAttendance(localStudentNumber, date);
  }
}
