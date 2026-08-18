import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Student/domain/Repo/library_repo.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';

class GetBooksUseCase {
  final LibraryRepo repository;

  GetBooksUseCase({required this.repository});

  Future<Either<Failures, List<BookEntity>>> call() async {
    return await repository.getBooks();
  }
}
