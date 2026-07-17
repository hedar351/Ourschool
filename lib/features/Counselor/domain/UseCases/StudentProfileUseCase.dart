import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_studentFullProfile.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';

class Studentprofileusecase {
  final CounselorRepo repository;

  Studentprofileusecase({required this.repository});

  Future<Either<Failures, CounselorStudentfullprofile>> call(
    int localStudentNumber,
  ) async {
    return await repository.getCounselorStudentfullProfile(localStudentNumber);
  }
}
