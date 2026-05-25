import 'package:dartz/dartz.dart';
import 'package:school/features/Auth/domain/entities/auth_entities.dart';
import 'package:school/features/Auth/domain/repo/auth_repo.dart';

import '../../../../core/error/failures.dart';

class LoginUseCase {
  final AuthRepo repository;

  LoginUseCase({required this.repository});

  Future<Either<Failures, AuthEntities>> call(
    String username,
    String password,
    bool rememberMe,
  ) async {
    return await repository.login(username, password, rememberMe);
  }
}
