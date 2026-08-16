import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';

class ApproveReservationsUseCase {
  final LibrarianRepo repository;

  ApproveReservationsUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(
    int localBookNumber,
    int localStudentNumber,
  ) async {
    return await repository.approveReservations(
      localBookNumber,
      localStudentNumber,
    );
  }
}
