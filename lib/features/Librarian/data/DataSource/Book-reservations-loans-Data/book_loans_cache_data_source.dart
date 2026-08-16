// lib/features/Librarian/data/DataSource/loans/book_loans_cache_data_source.dart

import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Librarian/data/Model/Book-reservations-loans-Model/book_loan_model.dart';

abstract class BookLoansCacheDataSource {
  Future<void> cacheBookLoans(BookLoanModel loans, int localBookNumber);
  Future<void> deleteAllBookLoans();
  Future<void> deleteBookLoans(
    int localBookNumber,
  ); //===========================
  Future<BookLoanModel> getCachedBookLoans(int localBookNumber);
  Stream<BookLoanModel?> watchCachedBookLoans(int localBookNumber);
}

class BookLoansCacheDataSourceImpl implements BookLoansCacheDataSource {
  static const String _keyPrefix = 'book_loans_';
  final Box<BookLoanModel> box;

  BookLoansCacheDataSourceImpl({required this.box});
  @override
  Future<void> cacheBookLoans(BookLoanModel loans, int localBookNumber) async {
    final key = _getKey(localBookNumber);
    print(' [BookLoans Cache] تخزين استعارات الكتاب في الكاش (المفتاح: $key)');
    await box.put(key, loans);
    print(' [BookLoans Cache] تم التخزين بنجاح');
  }

  @override
  Future<void> deleteAllBookLoans() async {
    await box.clear();
    print(' [BookLoans Cache] تم الحذف');
  }

  // ==============================================
  @override
  Future<void> deleteBookLoans(int localBookNumber) async {
    final keysToDelete = box.keys.where((key) {
      return key is String && key.startsWith('book_loans_${localBookNumber}_');
    }).toList();
    if (keysToDelete.isNotEmpty) {
      await box.deleteAll(keysToDelete);
      print(' [BookLoans Cache] تم حذف كاش استعارات الكتاب $localBookNumber');
    }
  }
  // ==============================================

  @override
  Future<BookLoanModel> getCachedBookLoans(int localBookNumber) async {
    final key = _getKey(localBookNumber);
    print(
      ' [BookLoans Cache] محاولة قراءة استعارات الكتاب من الكاش (المفتاح: $key)',
    );
    final cached = box.get(key);
    if (cached == null) {
      print(' [BookLoans Cache] الكاش فارغ');
      throw EmptyCacheExp();
    }
    print(' [BookLoans Cache] تم استرجاع استعارات الكتاب من الكاش');
    return cached;
  }

  @override
  Stream<BookLoanModel?> watchCachedBookLoans(int localBookNumber) {
    final key = _getKey(localBookNumber);
    print(' [BookLoans Cache] بدء مراقبة التغييرات في الكاش (المفتاح: $key)');
    return box.watch(key: key).map((event) {
      final cached = box.get(key);
      if (cached != null) {
        print(' [BookLoans Cache] تغيير في استعارات الكتاب');
      } else {
        print(' [BookLoans Cache] الكاش أصبح فارغاً');
      }
      return cached;
    });
  }

  String _getKey(int localBookNumber) => '$_keyPrefix$localBookNumber';
}
