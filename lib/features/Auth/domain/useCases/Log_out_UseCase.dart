import 'package:dartz/dartz.dart';
import 'package:school/features/Auth/domain/repo/auth_repo.dart';
import 'package:school/features/Student/data/DataSource/StudentCacheDataSource.dart';

import '../../../../core/error/failures.dart';

class LogOutUseCase {
  final AuthRepo repository;
  final StudentCacheDataSource studentCacheDataSource;

  LogOutUseCase({
    required this.repository,
    required this.studentCacheDataSource,
  });

  Future<Either<Failures, Unit>> call() async {
    try {
      await studentCacheDataSource.deleteProfile();

      return await repository.logout();
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
