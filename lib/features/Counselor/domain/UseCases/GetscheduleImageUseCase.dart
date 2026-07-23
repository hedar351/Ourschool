import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/scheduleImageEntity/GetscheduleImageEntity.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';

class Getscheduleimageusecase {
  final CounselorRepo repository;

  Getscheduleimageusecase({required this.repository});

  Future<Either<Failures, Getscheduleimageentity>> call(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    return await repository.getscheduleImage(
      localGradeNumber,
      localSectionNumber,
    );
  }
}
