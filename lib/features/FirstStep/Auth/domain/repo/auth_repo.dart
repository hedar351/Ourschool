import 'package:dartz/dartz.dart';
import 'package:school/features/FirstStep/Auth/domain/entities/auth_entities.dart';

import '../../../../../core/error/failures.dart';

abstract class AuthRepo {
  Future<Either<Failures, AuthEntities>> getuser();
  Future<Either<Failures, AuthEntities>> login(
    String username,
    String password,
    bool rememberMe,
  );
  Future<Either<Failures, Unit>> logout();
}
