import 'package:dartz/dartz.dart';
import 'package:school/features/Auth/domain/repo/auth_repo.dart';

import '../../../../core/error/failures.dart';

class LogOutUseCase {
  final AuthRepo repository;

  LogOutUseCase({required this.repository});

  Future<Either<Failures, Unit>> call() async {
    return await repository.logout();
  }
}
