// lib/features/Library/domain/repositories/library_repo.dart

import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';
import 'package:school/features/Student/domain/entity/Library/reserveEntity.dart';

abstract class LibraryRepo {
  Future<Either<Failures, List<BookEntity>>> getBooks();

  Future<Either<Failures, List<BookEntity>>> getBooksWithCache();

  Future<Either<Failures, Reserveentity>> reserveBook(int localBookNumber);

  Stream<List<BookEntity>> watchCachedBooks();
}
