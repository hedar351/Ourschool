import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/book_loan_entity.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/book_reservations_entity.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_loans_Entity.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_reservations_Entity.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';

abstract class LibrarianRepo {
  Future<Either<Failures, Unit>> addBooks(
    String title,
    String author,
    int copies,
  );
  Future<Either<Failures, Unit>> approveReservations(
    int localBookNumber,
    int localStudentNumber,
  );
  Future<void> deleteBookLoansCache(int localBookNumber);

  Future<void> deleteBookReservationsCache(int localBookNumber);

  Future<Either<Failures, Unit>> deleteBooks(int localBookNumber);
  Future<Either<Failures, Unit>> editBooks(
    int localBookNumber,
    String title,
    String author,
    int copies,
  );

  Future<Either<Failures, BookLoanEntity>> getBookLoans(int localBookNumber);
  Future<Either<Failures, BookLoanEntity>> getBookLoansWithCache(
    int localBookNumber,
  );

  Future<Either<Failures, BookReservationsEntity>> getBookReservations(
    String status,
    int localBookNumber,
  );

  Future<Either<Failures, BookReservationsEntity>> getBookReservationsWithCache(
    String status,
    int localBookNumber,
  );

  Future<Either<Failures, List<BookEntity>>> getBooksLibrarian();

  Future<Either<Failures, List<BookEntity>>> getBooksWithCacheLibrarian();

  Future<Either<Failures, LibrarianReservationsEntity>>
  getgetLibrarianReservationsWithCache(String status);

  Future<Either<Failures, LibrarianLoansEntity>> getLibrarianLeons();

  Future<Either<Failures, LibrarianLoansEntity>> getLibrarianLeonsWithCache();

  Future<Either<Failures, LibrarianReservationsEntity>>
  getLibrarianReservations(String status);
  Future<Either<Failures, Unit>> postLoans(
    int localStudentNumber,
    int localBookNumber,
  );

  Future<Either<Failures, Unit>> rejectReservations(
    int localBookNmber,
    int localStudentNumber,
  );
  Future<Either<Failures, Unit>> returnLoans(
    int localStudentNumber,
    int localBookNumber,
  );
  Stream<List<BookEntity>> watchCachedBooksLibrarian();
  Stream<BookLoanEntity> watchCachedgetBookLoans(int localBookNumbe);
  Stream<BookReservationsEntity> watchCachedgetBookReservations(
    String status,
    int localBookNumbe,
  );
  Stream<LibrarianLoansEntity> watchCachedgetLibrarianLeons();
  Stream<LibrarianReservationsEntity> watchCachedgetLibrarianReservations(
    String status,
  );
}
