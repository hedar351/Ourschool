import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Activities/domain/repo/activites_repo.dart';

class EditActivityUseCase {
  final ActivitesRepo repository;

  EditActivityUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(
    int localActivityId,
    String title,
    String description,
    String expiryDate,
  ) async {
    return await repository.editActivities(
      localActivityId,
      title,
      description,
      expiryDate,
    );
  }
}
