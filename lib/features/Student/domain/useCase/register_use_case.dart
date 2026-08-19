import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Student/domain/Repo/StudentRepo.dart';

class RegisterUseCase {
  final StudentRepo repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(int activityId) async {
    return await repository.register(activityId);
  }
}
