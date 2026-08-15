import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_loans_model.dart';

abstract class LibrarianLoansCacheDataSource {
  Future<void> cacheLibrarianLoans(LibrarianLoansModel loans, {String? status});
  Future<void> deleteLibrarianLoans({String? status});
  Future<LibrarianLoansModel> getCachedLibrarianLoans({String? status});
  Stream<LibrarianLoansModel?> watchCachedLibrarianLoans({String? status});
}

class LibrarianLoansCacheDataSourceImpl
    implements LibrarianLoansCacheDataSource {
  static const String _keyPrefix = 'librarian_loans_';
  final Box<LibrarianLoansModel> box;

  LibrarianLoansCacheDataSourceImpl({required this.box});

  @override
  Future<void> cacheLibrarianLoans(
    LibrarianLoansModel loans, {
    String? status,
  }) async {
    final key = _getKey(status: status);
    print(' [Librarian Loans Cache] تخزين الاستعارات في الكاش (المفتاح: $key)');
    await box.put(key, loans);
    print(' [Librarian Loans Cache] تم التخزين بنجاح');
  }

  @override
  Future<void> deleteLibrarianLoans({String? status}) async {
    if (status == null || status == 'all') {
      final keysToDelete = box.keys
          .where((key) => key is String && key.startsWith(_keyPrefix))
          .toList();

      if (keysToDelete.isNotEmpty) {
        await box.deleteAll(keysToDelete);
        print(
          ' [Librarian Loans Cache] تم حذف جميع مفاتيح الاستعارات (عدد: ${keysToDelete.length})',
        );
      } else {
        print(' [Librarian Loans Cache] لا توجد مفاتيح للحذف');
      }
    } else {
      final key = _getKey(status: status);
      print(' [Librarian Loans Cache] حذف الاستعارات من الكاش (المفتاح: $key)');
      await box.delete(key);
      print(' [Librarian Loans Cache] تم الحذف');
    }
  }

  @override
  Future<LibrarianLoansModel> getCachedLibrarianLoans({String? status}) async {
    final key = _getKey(status: status);
    print(
      ' [Librarian Loans Cache] محاولة قراءة الاستعارات من الكاش (المفتاح: $key)',
    );
    final cached = box.get(key);
    if (cached == null) {
      print(' [Librarian Loans Cache] الكاش فارغ');
      throw EmptyCacheExp();
    }
    print(' [Librarian Loans Cache] تم استرجاع الاستعارات من الكاش');
    return cached;
  }

  @override
  Stream<LibrarianLoansModel?> watchCachedLibrarianLoans({String? status}) {
    final key = _getKey(status: status);
    print(
      ' [Librarian Loans Cache] بدء مراقبة التغييرات في الكاش (المفتاح: $key)',
    );
    return box.watch(key: key).map((event) {
      final cached = box.get(key);
      if (cached != null) {
        print(' [Librarian Loans Cache] تغيير في الاستعارات');
      } else {
        print(' [Librarian Loans Cache] الكاش أصبح فارغاً');
      }
      return cached;
    });
  }

  String _getKey({String? status}) => '$_keyPrefix${status ?? 'all'}';
}
