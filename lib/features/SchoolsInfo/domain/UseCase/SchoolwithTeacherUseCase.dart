import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/SchoolsInfo/domain/Repo/SchoolRepository.dart';

import '../Entities/SchoolWithTeacherEntity.dart';

class SchoolwithTeacherUseCase {
  SchoolRepository repo;
  SchoolwithTeacherUseCase({required this.repo});

  Future<Either<Failures, Schoolwithteacherentity>> call() async {
    return await repo.getSchoolwithteachere();
  }
}
