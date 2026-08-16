import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';

class EditBookUseCase {
  final LibrarianRepo repository;

  EditBookUseCase({required this.repository});

  Future<Either<Failures, Unit>> call(
    int localBookNumber,
    String title,
    String author,
    int copies,
  ) async {
    return await repository.editBooks(localBookNumber, title, author, copies);
  }
}
