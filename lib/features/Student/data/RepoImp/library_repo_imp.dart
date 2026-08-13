import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/services/network.dart';
import 'package:school/features/Student/data/DataSource/library_cache_data_source.dart';
import 'package:school/features/Student/data/DataSource/library_remote_data_source.dart';
import 'package:school/features/Student/domain/Repo/library_repo.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';
import 'package:school/features/Student/domain/entity/Library/reservations.dart';
import 'package:school/features/Student/domain/entity/Library/reserveEntity.dart';

class LibraryRepoImp implements LibraryRepo {
  final LibraryRemoteDataSource remote;
  final LibraryCacheDataSource cache;
  final NetworkInfo networkInfo;

  LibraryRepoImp({
    required this.remote,
    required this.cache,
    required this.networkInfo,
  });

  // ============================================================
  // ====== BOOKS ======
  // ============================================================

  @override
  Future<Either<Failures, List<BookEntity>>> getBooks() async {
    print('📚 [Repo] getBooks() - محاولة القراءة من الكاش أولاً');
    try {
      final cached = await cache.getCachedBooks();
      print('✅ [Repo] تم إرجاع البيانات من الكاش');
      return Right(cached.map((e) => e.toEntity()).toList());
    } on EmptyCacheExp {
      print('⚠️ [Repo] الكاش فارغ، التوجه للشبكة');
      return await _fetchBooksFromNetworkAndCache();
    } catch (e) {
      print('🔴 [Repo] خطأ غير متوقع في الكاش: $e');
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failures, List<BookEntity>>> getBooksWithCache() async {
    print('📶 [Repo] getBooksWithCache() - التحقق من الاتصال');
    final isConnected = await networkInfo.isConnected;
    print(isConnected ? '✅ [Repo] متصل بالإنترنت' : '❌ [Repo] غير متصل');
    if (isConnected) {
      return await _fetchBooksFromNetworkAndCache();
    } else {
      print('🔴 [Repo] لا يوجد اتصال، إرجاع OfflineFailure');
      return Left(OfflineFailure());
    }
  }

  // ============================================================
  // ====== RESERVATIONS ======
  // ============================================================

  @override
  Future<Either<Failures, Reservations>> getReserveBook() async {
    print('📚 [Repo] getReserveBook() - محاولة القراءة من الكاش أولاً');
    try {
      final cached = await cache.getCachedReservations();
      print('✅ [Repo] تم إرجاع الحجوزات من الكاش');
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      print('⚠️ [Repo] الكاش فارغ، التوجه للشبكة');
      return await _fetchReservationsFromNetworkAndCache();
    } catch (e) {
      print('🔴 [Repo] خطأ غير متوقع في الكاش: $e');
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failures, Reservations>> getReserveBookWithCache() async {
    print('📶 [Repo] getReserveBookWithCache() - التحقق من الاتصال');
    final isConnected = await networkInfo.isConnected;
    print(isConnected ? '✅ [Repo] متصل بالإنترنت' : '❌ [Repo] غير متصل');
    if (isConnected) {
      return await _fetchReservationsFromNetworkAndCache();
    } else {
      print('🔴 [Repo] لا يوجد اتصال، إرجاع OfflineFailure');
      return Left(OfflineFailure());
    }
  }

  // ============================================================
  // ====== RESERVE BOOK ======
  // ============================================================

  @override
  Future<Either<Failures, Reserveentity>> reserveBook(
    int localBookNumber,
  ) async {
    print('📚 [Repo] reserveBook() - حجز الكتاب رقم: $localBookNumber');

    if (!await networkInfo.isConnected) {
      print('🔴 [Repo] لا يوجد اتصال بالإنترنت');
      return Left(OfflineFailure());
    }

    try {
      final remoteReserve = await remote.reserveBook(localBookNumber);
      print('✅ [Repo] تم حجز الكتاب بنجاح');
      await _fetchReservationsFromNetworkAndCache();
      return Right(remoteReserve.toEntity());
    } on ServerExp catch (e) {
      print('🔴 [Repo] فشل حجز الكتاب: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      print('🔴 [Repo] فشل حجز الكتاب: $e');
      return Left(ServerFailure(message: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Stream<List<BookEntity>> watchCachedBooks() {
    print('👀 [Repo] بدء مراقبة الكاش (Stream)');
    return cache.watchCachedBooks().map(
      (models) => models.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  Stream<Reservations> watchCachedReserveBook() {
    print('👀 [Repo] بدء مراقبة الكاش (الحجوزات)');
    return cache.watchCachedReservations().map(
      (model) =>
          model?.toEntity() ??
          const Reservations(
            message: '',
            totalReservations: 0,
            pendingReservations: 0,
            approvedReservations: 0,
            reserveBookInfo: [],
          ),
    );
  }

  // ============================================================
  // ====== HELPERS ======
  // ============================================================

  // ----- Books -----
  Future<Either<Failures, List<BookEntity>>>
  _fetchBooksFromNetworkAndCache() async {
    print('🌐 [Repo] _fetchBooksFromNetworkAndCache() - جلب من الشبكة');
    try {
      final remoteBooks = await remote.getBooks();
      print('✅ [Repo] تم جلب البيانات من الشبكة بنجاح');
      await cache.cacheBooks(remoteBooks);
      print('✅ [Repo] تم تخزين البيانات في الكاش');
      return Right(remoteBooks.map((e) => e.toEntity()).toList());
    } catch (e) {
      print('🔴 [Repo] فشل جلب البيانات من الشبكة: $e');
      return Left(ServerFailure());
    }
  }

  // ----- Reservations -----
  Future<Either<Failures, Reservations>>
  _fetchReservationsFromNetworkAndCache() async {
    print('🌐 [Repo] _fetchReservationsFromNetworkAndCache() - جلب من الشبكة');
    try {
      final remoteReservations = await remote.getReservations();
      print('✅ [Repo] تم جلب الحجوزات من الشبكة بنجاح');
      await cache.cacheReservations(remoteReservations);
      print('✅ [Repo] تم تخزين الحجوزات في الكاش');
      return Right(remoteReservations.toEntity());
    } catch (e) {
      print('🔴 [Repo] فشل جلب الحجوزات من الشبكة: $e');
      return Left(ServerFailure());
    }
  }
}
