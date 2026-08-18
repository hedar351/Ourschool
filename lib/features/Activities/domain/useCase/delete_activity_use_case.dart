import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Activities/domain/repo/activites_repo.dart';

class DeleteActivityUseCase {
  final ActivitesRepo repository;

  DeleteActivityUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(int localActivityId) async {
    return await repository.deleteActivities(localActivityId);
  }
}
