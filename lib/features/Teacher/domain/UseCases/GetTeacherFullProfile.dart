import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

class Getteacherfullprofile {
  final Teacherrepo repository;

  Getteacherfullprofile({required this.repository});

  Future<Either<Failures, TeacherFullprofileentity>> call() async {
    return await repository.getTeacherFullprofile();
  }
}
