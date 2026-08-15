import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/book_loan_entity.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';

class Getbookloansusecase {
  final LibrarianRepo repository;

  Getbookloansusecase({required this.repository});

  Future<Either<Failures, BookLoanEntity>> call(int localBookNumber) async {
    return await repository.getBookLoans(localBookNumber);
  }
}
