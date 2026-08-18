import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Activities/domain/repo/activites_repo.dart';

class AddActivityUseCase {
  final ActivitesRepo repository;

  AddActivityUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(
    String title,
    String description,
    String expiryDate,
  ) async {
    return await repository.addActivities(title, description, expiryDate);
  }
}
