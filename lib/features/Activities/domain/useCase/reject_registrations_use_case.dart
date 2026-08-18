import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Activities/domain/repo/activites_repo.dart';

class RejectRegistrationsUseCase {
  final ActivitesRepo repository;

  RejectRegistrationsUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(int id, int studentLocalNumber) async {
    return await repository.rejectRegistrations(id, studentLocalNumber);
  }
}
