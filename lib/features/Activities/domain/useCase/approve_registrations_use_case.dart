import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Activities/domain/repo/activites_repo.dart';

class ApproveRegistrationsUseCase {
  final ActivitesRepo repository;

  ApproveRegistrationsUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(int id, int studentLocalNumber) async {
    return await repository.approveRegistrations(id, studentLocalNumber);
  }
}
