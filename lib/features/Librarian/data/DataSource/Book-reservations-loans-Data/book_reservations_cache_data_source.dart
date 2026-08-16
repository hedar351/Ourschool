import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Librarian/data/Model/Book-reservations-loans-Model/book_reservations_model.dart';

abstract class BookReservationsCacheDataSource {
  Future<void> cacheBookReservations(
    BookReservationsModel reservations, {
    required String status,
    required int localBookNumber,
  });
  Future<void> deleteBookAllReservations();
  Future<void> deleteBookReservations(
    int localBookNumber,
  ); //======================
  Future<BookReservationsModel> getCachedBookReservations({
    required String status,
    required int localBookNumber,
  });
  Stream<BookReservationsModel?> watchCachedBookReservations({
    required String status,
    required int localBookNumber,
  });
}

class BookReservationsCacheDataSourceImpl
    implements BookReservationsCacheDataSource {
  static const String _keyPrefix = 'book_reservations_';
  final Box<BookReservationsModel> box;

  BookReservationsCacheDataSourceImpl({required this.box});
  @override
  Future<void> cacheBookReservations(
    BookReservationsModel reservations, {
    required String status,
    required int localBookNumber,
  }) async {
    final key = _getKey(status: status, localBookNumber: localBookNumber);
    print(' [BookReservations Cache] تخزين الحجوزات في الكاش (المفتاح: $key)');
    await box.put(key, reservations);
    print(' [BookReservations Cache] تم التخزين بنجاح');
  }

  @override
  Future<void> deleteBookAllReservations() async {
    await box.clear();
    print(' [BookReservations Cache] تم الحذف');
  }

  @override
  Future<void> deleteBookReservations(int localBookNumber) async {
    final keysToDelete = box.keys.where((key) {
      return key is String &&
          key.startsWith('book_reservations_${localBookNumber}_');
    }).toList();
    if (keysToDelete.isNotEmpty) {
      await box.deleteAll(keysToDelete);
      print(
        ' [BookReservations Cache] تم حذف كاش حجوزات الكتاب $localBookNumber',
      );
    }
  }

  @override
  Future<BookReservationsModel> getCachedBookReservations({
    required String status,
    required int localBookNumber,
  }) async {
    final key = _getKey(status: status, localBookNumber: localBookNumber);
    print(
      ' [BookReservations Cache] محاولة قراءة الحجوزات من الكاش (المفتاح: $key)',
    );
    final cached = box.get(key);
    if (cached == null) {
      print(' [BookReservations Cache] الكاش فارغ');
      throw EmptyCacheExp();
    }
    print(' [BookReservations Cache] تم استرجاع الحجوزات من الكاش');
    return cached;
  }

  @override
  Stream<BookReservationsModel?> watchCachedBookReservations({
    required String status,
    required int localBookNumber,
  }) {
    final key = _getKey(status: status, localBookNumber: localBookNumber);
    print(
      ' [BookReservations Cache] بدء مراقبة التغييرات في الكاش (المفتاح: $key)',
    );
    return box.watch(key: key).map((event) {
      final cached = box.get(key);
      if (cached != null) {
        print(' [BookReservations Cache] تغيير في الحجوزات');
      } else {
        print(' [BookReservations Cache] الكاش أصبح فارغاً');
      }
      return cached;
    });
  }

  String _getKey({required String status, required int localBookNumber}) {
    return '$_keyPrefix${localBookNumber}_$status';
  }
}
