// // lib/features/Library/data/datasources/library_cache_data_source.dart

// import 'package:hive/hive.dart';
// import 'package:school/core/error/EXP.dart';
// import 'package:school/features/Student/data/Model/LibraryModel/book_model.dart';

// abstract class LibraryCacheDataSource {
//   Future<void> cacheBooks(List<BookModel> books);
//   Future<void> deleteBooks();
//   Future<List<BookModel>> getCachedBooks();
//   Stream<List<BookModel>> watchCachedBooks();
// }

// class LibraryCacheDataSourceImpl implements LibraryCacheDataSource {
//   final Box<BookModel> box;

//   LibraryCacheDataSourceImpl({required this.box});

//   @override
//   Future<void> cacheBooks(List<BookModel> books) async {
//     print(' [Cache] تخزين ${books.length} كتاب في الكاش');
//     await box.clear();
//     await box.addAll(books);
//     print(' [Cache] تم التخزين بنجاح');
//   }

//   @override
//   Future<void> deleteBooks() async {
//     print(' [Cache] حذف الكتب من الكاش');
//     await box.clear();
//     print(' [Cache] تم الحذف');
//   }

//   @override
//   Future<List<BookModel>> getCachedBooks() async {
//     print(' [Cache] محاولة قراءة الكتب من الكاش');
//     final books = box.values.toList();
//     if (books.isEmpty) {
//       print(' [Cache] الكاش فارغ');
//       throw EmptyCacheExp();
//     }
//     print(' [Cache] تم استرجاع ${books.length} كتاب من الكاش');
//     return books;
//   }

//   @override
//   Stream<List<BookModel>> watchCachedBooks() {
//     print(' [Cache] بدء مراقبة التغييرات في الكاش');
//     return box.watch().map((event) {
//       final books = box.values.toList();
//       if (books.isNotEmpty) {
//         print(' [Cache] تغيير في الكاش: ${books.length} كتب');
//       } else {
//         print(' [Cache] الكاش أصبح فارغاً');
//       }
//       return books;
//     });
//   }
// }
// lib/features/Library/data/datasources/library_cache_data_source.dart

import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Student/data/Model/LibraryModel/book_model.dart';
import 'package:school/features/Student/data/Model/LibraryModel/reservations_model.dart';

abstract class LibraryCacheDataSource {
  // ----- Books -----
  Future<void> cacheBooks(List<BookModel> books);
  // ----- Reservations -----
  Future<void> cacheReservations(ReservationsModel reservations);
  Future<void> deleteBooks();
  Future<void> deleteReservations();

  Future<List<BookModel>> getCachedBooks();
  Future<ReservationsModel> getCachedReservations();
  Stream<List<BookModel>> watchCachedBooks();
  Stream<ReservationsModel?> watchCachedReservations();
}

class LibraryCacheDataSourceImpl implements LibraryCacheDataSource {
  final Box<BookModel> bookBox;
  final Box<ReservationsModel> reservationsBox;

  LibraryCacheDataSourceImpl({
    required this.bookBox,
    required this.reservationsBox,
  });

  // ============================================================
  // ====== BOOKS ======
  // ============================================================

  @override
  Future<void> cacheBooks(List<BookModel> books) async {
    print(' [Cache] تخزين ${books.length} كتاب في الكاش');
    await bookBox.clear();
    await bookBox.addAll(books);
    print(' [Cache] تم التخزين بنجاح');
  }

  // ============================================================
  // ====== RESERVATIONS ======
  // ============================================================

  @override
  Future<void> cacheReservations(ReservationsModel reservations) async {
    print('💾 [Cache] تخزين الحجوزات في الكاش');
    await reservationsBox.put('reservations', reservations);
    print('✅ [Cache] تم تخزين الحجوزات بنجاح');
  }

  @override
  Future<void> deleteBooks() async {
    print(' [Cache] حذف الكتب من الكاش');
    await bookBox.clear();
    print('[Cache] تم الحذف');
  }

  @override
  Future<void> deleteReservations() async {
    print('🗑️ [Cache] حذف الحجوزات من الكاش');
    await reservationsBox.delete('reservations');
    print('✅ [Cache] تم الحذف');
  }

  @override
  Future<List<BookModel>> getCachedBooks() async {
    print('[Cache] محاولة قراءة الكتب من الكاش');
    final books = bookBox.values.toList();
    if (books.isEmpty) {
      print(' [Cache] الكاش فارغ');
      throw EmptyCacheExp();
    }
    print('[Cache] تم استرجاع ${books.length} كتاب من الكاش');
    return books;
  }

  @override
  Future<ReservationsModel> getCachedReservations() async {
    print(' [Cache] محاولة قراءة الحجوزات من الكاش');
    final reservations = reservationsBox.get('reservations');
    if (reservations == null) {
      print(' [Cache] الكاش فارغ');
      throw EmptyCacheExp();
    }
    print(' [Cache] تم استرجاع الحجوزات من الكاش');
    return reservations;
  }

  @override
  Stream<List<BookModel>> watchCachedBooks() {
    print(' [Cache] بدء مراقبة التغييرات في الكاش (الكتب)');
    return bookBox.watch().map((event) {
      final books = bookBox.values.toList();
      if (books.isNotEmpty) {
        print(' [Cache] تغيير في الكاش: ${books.length} كتب');
      } else {
        print(' [Cache] الكاش أصبح فارغاً');
      }
      return books;
    });
  }

  @override
  Stream<ReservationsModel?> watchCachedReservations() {
    print(' [Cache] بدء مراقبة التغييرات في الكاش (الحجوزات)');
    return reservationsBox.watch(key: 'reservations').map((event) {
      final reservations = reservationsBox.get('reservations');
      if (reservations != null) {
        print(' [Cache] تغيير في الحجوزات');
      } else {
        print(' [Cache] الحجوزات أصبحت فارغة');
      }
      return reservations;
    });
  }
}
