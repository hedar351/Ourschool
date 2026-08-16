import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';

class RejectReservationsUseCase {
  final LibrarianRepo repository;

  RejectReservationsUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(
    int localBookNumber,
    int localStudentNumber,
  ) async {
    return await repository.rejectReservations(
      localBookNumber,
      localStudentNumber,
    );
  }
}
