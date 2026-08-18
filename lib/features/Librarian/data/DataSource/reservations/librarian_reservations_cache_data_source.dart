import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_reservations_model.dart';

abstract class LibrarianReservationsCacheDataSource {
  Future<void> cacheLibrarianReservations(
    LibrarianReservationsModel reservations, {
    String? status,
  });
  Future<void> deleteLibrarianReservations({String? status});
  Future<LibrarianReservationsModel> getCachedLibrarianReservations({
    String? status,
  });
  Stream<LibrarianReservationsModel?> watchCachedLibrarianReservations({
    String? status,
  });
}

class LibrarianReservationsCacheDataSourceImpl
    implements LibrarianReservationsCacheDataSource {
  static const String _keyPrefix = 'librarian_reservations_';
  final Box<LibrarianReservationsModel> box;

  LibrarianReservationsCacheDataSourceImpl({required this.box});

  @override
  Future<void> cacheLibrarianReservations(
    LibrarianReservationsModel reservations, {
    String? status,
  }) async {
    final key = _getKey(status: status);
    print(
      ' [Librarian Reservations Cache] تخزين الحجوزات في الكاش (المفتاح: $key)',
    );
    await box.put(key, reservations);
    print(' [Librarian Reservations Cache] تم التخزين بنجاح');
  }

  // @override
  // Future<void> deleteLibrarianReservations({String? status}) async {
  //   final key = _getKey(status: status);
  //   print(
  //     ' [Librarian Reservations Cache] حذف الحجوزات من الكاش (المفتاح: $key)',
  //   );
  //   await box.delete(key);
  //   print(' [Librarian Reservations Cache] تم الحذف');
  // }

  @override
  Future<void> deleteLibrarianReservations({String? status}) async {
    if (status == null || status == 'all') {
      final keysToDelete = box.keys
          .where((key) => key is String && key.startsWith(_keyPrefix))
          .toList();

      if (keysToDelete.isNotEmpty) {
        await box.deleteAll(keysToDelete);
        print(
          ' [Librarian Reservations Cache] تم حذف جميع مفاتيح الحجوزات (عدد: ${keysToDelete.length})',
        );
      } else {
        print(' [Librarian Reservations Cache] لا توجد مفاتيح للحذف');
      }
    } else {
      // حذف مفتاح حالة محددة فقط
      final key = _getKey(status: status);
      print(
        ' [Librarian Reservations Cache] حذف الحجوزات من الكاش (المفتاح: $key)',
      );
      await box.delete(key);
      print(' [Librarian Reservations Cache] تم الحذف');
    }
  }

  @override
  Future<LibrarianReservationsModel> getCachedLibrarianReservations({
    String? status,
  }) async {
    final key = _getKey(status: status);
    print(
      ' [Librarian Reservations Cache] محاولة قراءة الحجوزات من الكاش (المفتاح: $key)',
    );
    final cached = box.get(key);
    if (cached == null) {
      print(' [Librarian Reservations Cache] الكاش فارغ');
      throw EmptyCacheExp();
    }
    print(' [Librarian Reservations Cache] تم استرجاع الحجوزات من الكاش');
    return cached;
  }

  @override
  Stream<LibrarianReservationsModel?> watchCachedLibrarianReservations({
    String? status,
  }) {
    final key = _getKey(status: status);
    print(
      ' [Librarian Reservations Cache] بدء مراقبة التغييرات في الكاش (المفتاح: $key)',
    );
    return box.watch(key: key).map((event) {
      final cached = box.get(key);
      if (cached != null) {
        print(' [Librarian Reservations Cache] تغيير في الحجوزات');
      } else {
        print(' [Librarian Reservations Cache] الكاش أصبح فارغاً');
      }
      return cached;
    });
  }

  String _getKey({String? status}) => '$_keyPrefix${status ?? 'all'}';
}
