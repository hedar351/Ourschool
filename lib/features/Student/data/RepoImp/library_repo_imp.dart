// lib/features/Library/data/repositories/library_repo_imp.dart

import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/network.dart';
import 'package:school/features/Student/data/DataSource/library_cache_data_source.dart';
import 'package:school/features/Student/data/DataSource/library_remote_data_source.dart';
import 'package:school/features/Student/domain/Repo/library_repo.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';
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

  @override
  Future<Either<Failures, List<BookEntity>>> getBooks() async {
    print('📚 [Repo] getBooks() - محاولة القراءة من الكاش أولاً');
    try {
      final cached = await cache.getCachedBooks();
      print('✅ [Repo] تم إرجاع البيانات من الكاش');
      return Right(cached.map((e) => e.toEntity()).toList());
    } on EmptyCacheExp {
      print('⚠️ [Repo] الكاش فارغ، التوجه للشبكة');
      return await _fetchFromNetworkAndCache();
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
      return await _fetchFromNetworkAndCache();
    } else {
      print('🔴 [Repo] لا يوجد اتصال، إرجاع OfflineFailure');
      return Left(OfflineFailure());
    }
  }

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
      return Right(remoteReserve.toEntity());
    } catch (e) {
      print('🔴 [Repo] فشل حجز الكتاب: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<BookEntity>> watchCachedBooks() {
    print('👀 [Repo] بدء مراقبة الكاش (Stream)');
    return cache.watchCachedBooks().map(
      (models) => models.map((e) => e.toEntity()).toList(),
    );
  }

  // ---- Helper ----
  Future<Either<Failures, List<BookEntity>>> _fetchFromNetworkAndCache() async {
    print('🌐 [Repo] _fetchFromNetworkAndCache() - جلب من الشبكة');
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
}
