import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/book_reservations_entity.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';

class Getbookreservationsusecase {
  final LibrarianRepo repository;

  Getbookreservationsusecase({required this.repository});

  Future<Either<Failures, BookReservationsEntity>> call(
    String status,
    int localBookNumber,
  ) async {
    return await repository.getBookReservations(status, localBookNumber);
  }
}
