import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';

class ReturnLoansUseCase {
  final LibrarianRepo repository;

  ReturnLoansUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(
    int localBookNumber,
    int localStudentNumber,
  ) async {
    return await repository.returnLoans(localBookNumber, localStudentNumber);
  }
}
