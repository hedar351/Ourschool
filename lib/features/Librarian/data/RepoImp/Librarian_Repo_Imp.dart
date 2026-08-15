import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/services/network.dart';
import 'package:school/features/Librarian/data/DataSource/Book-reservations-loans-Data/book_loans_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/Book-reservations-loans-Data/book_loans_remote_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/Book-reservations-loans-Data/book_reservations_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/Book-reservations-loans-Data/book_reservations_remote_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/LibrarianRemoteDataSource.dart';
import 'package:school/features/Librarian/data/DataSource/loans/librarian_loans_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/loans/librarian_loans_remote_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/reservations/librarian_reservations_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/reservations/librarian_reservations_remote_data_source.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/book_loan_entity.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/book_reservations_entity.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_loans_Entity.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_reservations_Entity.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';
import 'package:school/features/Student/data/DataSource/library_cache_data_source.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';

class LibrarianRepoImp implements LibrarianRepo {
  final LibraryCacheDataSource cache;
  final NetworkInfo networkInfo;
  final LibrarianRemoteDataSource librarianRemoteDataSource;

  final LibrarianReservationsRemoteDataSource reservationsRemoteDataSource;
  final LibrarianReservationsCacheDataSource reservationsCacheDataSource;

  final LibrarianLoansRemoteDataSource loansRemoteDataSource;
  final LibrarianLoansCacheDataSource loansCacheDataSource;

  final BookReservationsRemoteDataSource bookReservationsRemoteDataSource;
  final BookReservationsCacheDataSource bookReservationsCacheDataSource;

  final BookLoansRemoteDataSource bookLoansRemoteDataSource;
  final BookLoansCacheDataSource bookLoansCacheDataSource;

  LibrarianRepoImp({
    required this.cache,
    required this.networkInfo,
    required this.librarianRemoteDataSource,
    required this.reservationsRemoteDataSource,
    required this.reservationsCacheDataSource,
    required this.loansRemoteDataSource,
    required this.loansCacheDataSource,
    required this.bookReservationsRemoteDataSource,
    required this.bookReservationsCacheDataSource,
    required this.bookLoansRemoteDataSource,
    required this.bookLoansCacheDataSource,
  });

  // ============================================================
  // ====== 1. الكتب (Books) ======
  // ============================================================

  @override
  Future<Either<Failures, Unit>> addBooks(
    String title,
    String author,
    int copies,
  ) async {
    print('[Repo] addBooks() - إضافة كتاب جديد');
    print('[Repo] العنوان: $title, المؤلف: $author, النسخ: $copies');

    if (!await networkInfo.isConnected) {
      print('🔴 [Repo] لا يوجد اتصال بالإنترنت');
      return Left(OfflineFailure());
    }

    try {
      await librarianRemoteDataSource.addBooks(title, author, copies);
      print(' [Repo] تم إضافة الكتاب بنجاح');
      await _fetchLibrarianBooksFromNetworkAndCache();
      return const Right(unit);
    } catch (e) {
      print('🔴 [Repo] فشل إضافة الكتاب: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // ============================================================
  // ====== 3. استعارات الكتاب (Book Loans) ======
  // ============================================================

  @override
  Future<Either<Failures, BookLoanEntity>> getBookLoans(
    int localBookNumber,
  ) async {
    print(' [Repo] getBookLoans() - محاولة القراءة من الكاش أولاً');
    print(' [Repo] رقم الكتاب: $localBookNumber');

    try {
      final cached = await bookLoansCacheDataSource.getCachedBookLoans(
        localBookNumber,
      );
      print(' [Repo] تم إرجاع استعارات الكتاب من الكاش');
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      print(' [Repo] الكاش فارغ، التوجه للشبكة');
      return await _fetchBookLoansFromNetworkAndCache(localBookNumber);
    } catch (e) {
      print('🔴 [Repo] خطأ غير متوقع في الكاش: $e');
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failures, BookLoanEntity>> getBookLoansWithCache(
    int localBookNumber,
  ) async {
    print(' [Repo] getBookLoansWithCache() - التحقق من الاتصال');
    print(' [Repo] رقم الكتاب: $localBookNumber');

    final isConnected = await networkInfo.isConnected;
    print(isConnected ? ' [Repo] متصل بالإنترنت' : '❌ [Repo] غير متصل');

    if (isConnected) {
      return await _fetchBookLoansFromNetworkAndCache(localBookNumber);
    } else {
      print('🔴 [Repo] لا يوجد اتصال، إرجاع OfflineFailure');
      return Left(OfflineFailure());
    }
  }

  // ============================================================
  // ====== 2. حجوزات الكتاب (Book Reservations) ======
  // ============================================================

  @override
  Future<Either<Failures, BookReservationsEntity>> getBookReservations(
    String status,
    int localBookNumber,
  ) async {
    print(' [Repo] getBookReservations() - محاولة القراءة من الكاش أولاً');
    print(' [Repo] رقم الكتاب: $localBookNumber, الحالة: $status');

    try {
      final cached = await bookReservationsCacheDataSource
          .getCachedBookReservations(
            status: status,
            localBookNumber: localBookNumber,
          );
      print(' [Repo] تم إرجاع حجوزات الكتاب من الكاش');
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      print(' [Repo] الكاش فارغ، التوجه للشبكة');
      return await _fetchBookReservationsFromNetworkAndCache(
        status: status,
        localBookNumber: localBookNumber,
      );
    } catch (e) {
      print('🔴 [Repo] خطأ غير متوقع في الكاش: $e');
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failures, BookReservationsEntity>> getBookReservationsWithCache(
    String status,
    int localBookNumber,
  ) async {
    print(' [Repo] getBookReservationsWithCache() - التحقق من الاتصال');
    print(' [Repo] رقم الكتاب: $localBookNumber, الحالة: $status');

    final isConnected = await networkInfo.isConnected;
    print(isConnected ? ' [Repo] متصل بالإنترنت' : '❌ [Repo] غير متصل');

    if (isConnected) {
      return await _fetchBookReservationsFromNetworkAndCache(
        status: status,
        localBookNumber: localBookNumber,
      );
    } else {
      print('🔴 [Repo] لا يوجد اتصال، إرجاع OfflineFailure');
      return Left(OfflineFailure());
    }
  }

  // ============================================================
  // ====== 4. الكتب العامة (Books) ======
  // ============================================================

  @override
  Future<Either<Failures, List<BookEntity>>> getBooksLibrarian() async {
    print(' [Repo] getBooksLibrarian() - محاولة القراءة من الكاش أولاً');
    try {
      final cached = await cache.getCachedBooks();
      print(' [Repo] تم إرجاع البيانات من الكاش');
      return Right(cached.map((e) => e.toEntity()).toList());
    } on EmptyCacheExp {
      print(' [Repo] الكاش فارغ، التوجه للشبكة');
      return await _fetchLibrarianBooksFromNetworkAndCache();
    } catch (e) {
      print('🔴 [Repo] خطأ غير متوقع في الكاش: $e');
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failures, List<BookEntity>>>
  getBooksWithCacheLibrarian() async {
    print(' [Repo] getBooksWithCacheLibrarian() - التحقق من الاتصال');
    final isConnected = await networkInfo.isConnected;
    print(isConnected ? ' [Repo] متصل بالإنترنت' : '❌ [Repo] غير متصل');
    if (isConnected) {
      return await _fetchLibrarianBooksFromNetworkAndCache();
    } else {
      print('🔴 [Repo] لا يوجد اتصال، إرجاع OfflineFailure');
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, LibrarianReservationsEntity>>
  getgetLibrarianReservationsWithCache(String status) async {
    print(' [Repo] getgetLibrarianReservationsWithCache() - التحقق من الاتصال');
    print(' [Repo] الحالة: $status');

    final isConnected = await networkInfo.isConnected;
    print(isConnected ? ' [Repo] متصل بالإنترنت' : '❌ [Repo] غير متصل');

    if (isConnected) {
      return await _fetchLibrarianReservationsFromNetworkAndCache(status);
    } else {
      print('🔴 [Repo] لا يوجد اتصال، إرجاع OfflineFailure');
      return Left(OfflineFailure());
    }
  }

  // ============================================================
  // ====== 6. الاستعارات العامة (Loans) ======
  // ============================================================

  @override
  Future<Either<Failures, LibrarianLoansEntity>> getLibrarianLeons() async {
    print(' [Repo] getLibrarianLeons() - محاولة القراءة من الكاش أولاً');
    try {
      final cached = await loansCacheDataSource.getCachedLibrarianLoans();
      print(' [Repo] تم إرجاع الاستعارات من الكاش');
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      print(' [Repo] الكاش فارغ، التوجه للشبكة');
      return await _fetchLibrarianLoansFromNetworkAndCache();
    } catch (e) {
      print('🔴 [Repo] خطأ غير متوقع في الكاش: $e');
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failures, LibrarianLoansEntity>>
  getLibrarianLeonsWithCache() async {
    print(' [Repo] getLibrarianLeonsWithCache() - التحقق من الاتصال');
    final isConnected = await networkInfo.isConnected;
    print(isConnected ? ' [Repo] متصل بالإنترنت' : '❌ [Repo] غير متصل');

    if (isConnected) {
      return await _fetchLibrarianLoansFromNetworkAndCache();
    } else {
      print('🔴 [Repo] لا يوجد اتصال، إرجاع OfflineFailure');
      return Left(OfflineFailure());
    }
  }

  // ============================================================
  // ====== 5. الحجوزات العامة (Reservations) ======
  // ============================================================

  @override
  Future<Either<Failures, LibrarianReservationsEntity>>
  getLibrarianReservations(String status) async {
    print(' [Repo] getLibrarianReservations() - محاولة القراءة من الكاش أولاً');
    print(' [Repo] الحالة: $status');

    try {
      final cached = await reservationsCacheDataSource
          .getCachedLibrarianReservations(status: status);
      print(' [Repo] تم إرجاع الحجوزات من الكاش');
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      print(' [Repo] الكاش فارغ، التوجه للشبكة');
      return await _fetchLibrarianReservationsFromNetworkAndCache(status);
    } catch (e) {
      print('🔴 [Repo] خطأ غير متوقع في الكاش: $e');
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Stream<List<BookEntity>> watchCachedBooksLibrarian() {
    print('[Repo] بدء مراقبة الكاش (الكتب)');
    return cache.watchCachedBooks().map(
      (models) => models.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  Stream<BookLoanEntity> watchCachedgetBookLoans(int localBookNumber) {
    print(' [Repo] بدء مراقبة الكاش (استعارات الكتاب)');
    return bookLoansCacheDataSource
        .watchCachedBookLoans(localBookNumber)
        .map((model) => model?.toEntity() ?? _emptyBookLoansEntity());
  }

  @override
  Stream<BookReservationsEntity> watchCachedgetBookReservations(
    String status,
    int localBookNumber,
  ) {
    print(' [Repo] بدء مراقبة الكاش (حجوزات الكتاب)');
    return bookReservationsCacheDataSource
        .watchCachedBookReservations(
          status: status,
          localBookNumber: localBookNumber,
        )
        .map((model) => model?.toEntity() ?? _emptyBookReservationsEntity());
  }

  @override
  Stream<LibrarianLoansEntity> watchCachedgetLibrarianLeons() {
    print(
      ' [Repo] watchCachedgetLibrarianLeons() - بدء مراقبة الكاش للاستعارات',
    );
    return loansCacheDataSource.watchCachedLibrarianLoans().map(
      (model) => model?.toEntity() ?? _emptyLoansEntity(),
    );
  }

  @override
  Stream<LibrarianReservationsEntity> watchCachedgetLibrarianReservations(
    String status,
  ) {
    print(' [Repo] بدء مراقبة الكاش (الحجوزات)');
    return reservationsCacheDataSource
        .watchCachedLibrarianReservations(status: status)
        .map((model) => model?.toEntity() ?? _emptyReservationsEntity());
  }

  BookLoanEntity _emptyBookLoansEntity() {
    return const BookLoanEntity(
      id: 0,
      title: '',
      localBookNumber: 0,
      author: '',
      totalCopies: 0,
      availableCopies: 0,
      reservedCopies: 0,
      availableForLoan: 0,
      isAvailable: false,
      statisticsLoans: null,
      reservations: [],
    );
  }

  // ============================================================
  // ====== الكيانات الفارغة ======
  // ============================================================

  BookReservationsEntity _emptyBookReservationsEntity() {
    return const BookReservationsEntity(
      id: 0,
      title: '',
      localBookNumber: 0,
      author: '',
      availableCopies: 0,
      reservedCopies: 0,
      availableForLoan: 0,
      librarianReservationsEntity: null,
    );
  }

  LibrarianLoansEntity _emptyLoansEntity() {
    return const LibrarianLoansEntity(
      totalCount: 0,
      activeCount: 0,
      returnedCount: 0,
      loans: [],
    );
  }

  LibrarianReservationsEntity _emptyReservationsEntity() {
    return const LibrarianReservationsEntity(
      totalCount: 0,
      pendingCount: 0,
      approvedCount: 0,
      rejectedCount: 0,
      cancelledCount: 0,
      expiredCount: 0,
      reservations: [],
    );
  }

  // ----- استعارات الكتاب -----
  Future<Either<Failures, BookLoanEntity>> _fetchBookLoansFromNetworkAndCache(
    int localBookNumber,
  ) async {
    print(
      ' [Repo] _fetchBookLoansFromNetworkAndCache() - جلب استعارات الكتاب من الشبكة',
    );
    try {
      final remoteLoans = await bookLoansRemoteDataSource.getBookLoans(
        localBookNumber,
      );
      print(' [Repo] تم جلب استعارات الكتاب من الشبكة بنجاح');
      await bookLoansCacheDataSource.cacheBookLoans(
        remoteLoans,
        localBookNumber,
      );
      print(' [Repo] تم تخزين استعارات الكتاب في الكاش');
      return Right(remoteLoans.toEntity());
    } catch (e) {
      print('🔴 [Repo] فشل جلب استعارات الكتاب من الشبكة: $e');
      return Left(ServerFailure());
    }
  }

  // ----- حجوزات الكتاب -----
  Future<Either<Failures, BookReservationsEntity>>
  _fetchBookReservationsFromNetworkAndCache({
    required String status,
    required int localBookNumber,
  }) async {
    print(
      ' [Repo] _fetchBookReservationsFromNetworkAndCache() - جلب حجوزات الكتاب من الشبكة',
    );
    try {
      final remoteReservations = await bookReservationsRemoteDataSource
          .getBookReservations(
            status: status,
            localBookNumber: localBookNumber,
          );
      print(' [Repo] تم جلب حجوزات الكتاب من الشبكة بنجاح');
      await bookReservationsCacheDataSource.cacheBookReservations(
        remoteReservations,
        status: status,
        localBookNumber: localBookNumber,
      );
      print(' [Repo] تم تخزين حجوزات الكتاب في الكاش');
      return Right(remoteReservations.toEntity());
    } catch (e) {
      print('🔴 [Repo] فشل جلب حجوزات الكتاب من الشبكة: $e');
      return Left(ServerFailure());
    }
  }

  // ============================================================
  // ====== الدوال المساعدة (Helper) ======
  // ============================================================

  // ----- الكتب -----
  Future<Either<Failures, List<BookEntity>>>
  _fetchLibrarianBooksFromNetworkAndCache() async {
    print(
      ' [Repo] _fetchLibrarianBooksFromNetworkAndCache() - جلب الكتب من الشبكة',
    );
    try {
      final remoteBooks = await librarianRemoteDataSource.getBooks();
      print(' [Repo] تم جلب الكتب من الشبكة بنجاح');
      await cache.cacheBooks(remoteBooks);
      print(' [Repo] تم تخزين الكتب في الكاش');
      return Right(remoteBooks.map((e) => e.toEntity()).toList());
    } catch (e) {
      print('🔴 [Repo] فشل جلب الكتب من الشبكة: $e');
      return Left(ServerFailure());
    }
  }

  // ----- الاستعارات العامة -----
  Future<Either<Failures, LibrarianLoansEntity>>
  _fetchLibrarianLoansFromNetworkAndCache() async {
    print(
      ' [Repo] _fetchLibrarianLoansFromNetworkAndCache() - جلب الاستعارات من الشبكة',
    );
    try {
      final remoteLoans = await loansRemoteDataSource.getLibrarianLoans();
      print(' [Repo] تم جلب الاستعارات من الشبكة بنجاح');
      await loansCacheDataSource.cacheLibrarianLoans(remoteLoans);
      print(' [Repo] تم تخزين الاستعارات في الكاش');
      return Right(remoteLoans.toEntity());
    } catch (e) {
      print('🔴 [Repo] فشل جلب الاستعارات من الشبكة: $e');
      return Left(ServerFailure());
    }
  }

  // ----- الحجوزات العامة -----
  Future<Either<Failures, LibrarianReservationsEntity>>
  _fetchLibrarianReservationsFromNetworkAndCache(String status) async {
    print(
      ' [Repo] _fetchLibrarianReservationsFromNetworkAndCache() - جلب الحجوزات من الشبكة',
    );
    try {
      final remoteReservations = await reservationsRemoteDataSource
          .getLibrarianReservations(status: status);
      print(' [Repo] تم جلب الحجوزات من الشبكة بنجاح');
      await reservationsCacheDataSource.cacheLibrarianReservations(
        remoteReservations,
        status: status,
      );
      print(' [Repo] تم تخزين الحجوزات في الكاش');
      return Right(remoteReservations.toEntity());
    } catch (e) {
      print('🔴 [Repo] فشل جلب الحجوزات من الشبكة: $e');
      return Left(ServerFailure());
    }
  }
}
