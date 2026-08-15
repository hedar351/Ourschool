import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';

class Addbooksusecase {
  final LibrarianRepo repository;

  Addbooksusecase({required this.repository});

  Future<Either<Failures, Unit>> call(
    String title,
    String author,
    int copies,
  ) async {
    return await repository.addBooks(title, author, copies);
  }
}
