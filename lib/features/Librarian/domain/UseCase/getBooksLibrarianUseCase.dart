// lib/features/Library/domain/usecases/get_books_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';

class Getbookslibrarianusecase {
  final LibrarianRepo repository;

  Getbookslibrarianusecase({required this.repository});

  Future<Either<Failures, List<BookEntity>>> call() async {
    return await repository.getBooksLibrarian();
  }
}
