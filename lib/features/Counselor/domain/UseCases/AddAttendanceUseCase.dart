import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';

class AddAttendanceUseCase {
  final CounselorRepo repository;

  AddAttendanceUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(
    int localStudentNumber,
    String date,
  ) async {
    return await repository.addAttendance(localStudentNumber, date);
  }
}
