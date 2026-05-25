import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_entities.dart';
import '../repo/auth_repo.dart';

class GetUserUsecase {
  final AuthRepo repository;

  GetUserUsecase({required this.repository});

  Future<Either<Failures, AuthEntities>> call() async {
    return await repository.getuser();
  }
}
