import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';

class DeleteBookUseCase {
  final LibrarianRepo repository;

  DeleteBookUseCase({required this.repository});
  Future<Either<Failures, Unit>> call(int localBookNumber) async {
    final result = await repository.deleteBooks(localBookNumber);
    result.fold((failure) => Left(failure), (_) async {
      await repository.deleteBookReservationsCache(localBookNumber);
      await repository.deleteBookLoansCache(localBookNumber);
      return const Right(unit);
    });

    return result;
  }
}
