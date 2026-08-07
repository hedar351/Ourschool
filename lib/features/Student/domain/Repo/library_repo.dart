import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';
import 'package:school/features/Student/domain/entity/Library/reservations.dart';
import 'package:school/features/Student/domain/entity/Library/reserveEntity.dart';

abstract class LibraryRepo {
  //------------GetBooks------------//
  Future<Either<Failures, List<BookEntity>>> getBooks();

  Future<Either<Failures, List<BookEntity>>> getBooksWithCache();
  //------------GetReserveBook------------//

  Future<Either<Failures, Reservations>> getReserveBook();

  Future<Either<Failures, Reservations>> getReserveBookWithCache();

  //------------ReserveBook------------//
  Future<Either<Failures, Reserveentity>> reserveBook(int localBookNumber);
  // watchCached
  Stream<List<BookEntity>> watchCachedBooks();
  Stream<Reservations> watchCachedReserveBook();
}
