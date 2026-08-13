import 'package:dartz/dartz.dart';
import 'package:school/features/FirstStep/Auth/domain/entities/auth_entities.dart';
import 'package:school/features/FirstStep/Auth/domain/repo/auth_repo.dart';
import 'package:school/features/Student/data/DataSource/StudentCacheDataSource.dart';

import '../../../../../core/error/failures.dart';

class LoginUseCase {
  final AuthRepo repository;
  final StudentCacheDataSource studentCacheDataSource;

  LoginUseCase({
    required this.repository,
    required this.studentCacheDataSource,
  });

  Future<Either<Failures, AuthEntities>> call(
    String username,
    String password,
    bool rememberMe,
  ) async {
    try {
      await studentCacheDataSource.deleteProfile();

      return await repository.login(username, password, rememberMe);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
