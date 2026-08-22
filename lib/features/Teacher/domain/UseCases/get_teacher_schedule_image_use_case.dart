import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Counselor/domain/Entities/scheduleImageEntity/GetscheduleImageEntity.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

class GetTeacherScheduleImageUseCase {
  final Teacherrepo repository;

  GetTeacherScheduleImageUseCase({required this.repository});
  Future<Either<Failures, Getscheduleimageentity>> call(int schoolId) async {
    return await repository.getTeacherScheduleImage(schoolId);
  }
}
