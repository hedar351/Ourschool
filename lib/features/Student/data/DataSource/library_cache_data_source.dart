// lib/features/Library/data/datasources/library_cache_data_source.dart

import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Student/data/Model/LibraryModel/book_model.dart';

abstract class LibraryCacheDataSource {
  Future<void> cacheBooks(List<BookModel> books);
  Future<void> deleteBooks();
  Future<List<BookModel>> getCachedBooks();
  Stream<List<BookModel>> watchCachedBooks();
}

class LibraryCacheDataSourceImpl implements LibraryCacheDataSource {
  final Box<BookModel> box;

  LibraryCacheDataSourceImpl({required this.box});

  @override
  Future<void> cacheBooks(List<BookModel> books) async {
    print('💾 [Cache] تخزين ${books.length} كتاب في الكاش');
    await box.clear();
    await box.addAll(books);
    print('✅ [Cache] تم التخزين بنجاح');
  }

  @override
  Future<void> deleteBooks() async {
    print('🗑️ [Cache] حذف الكتب من الكاش');
    await box.clear();
    print('✅ [Cache] تم الحذف');
  }

  @override
  Future<List<BookModel>> getCachedBooks() async {
    print('📂 [Cache] محاولة قراءة الكتب من الكاش');
    final books = box.values.toList();
    if (books.isEmpty) {
      print('⚠️ [Cache] الكاش فارغ');
      throw EmptyCacheExp();
    }
    print('✅ [Cache] تم استرجاع ${books.length} كتاب من الكاش');
    return books;
  }

  @override
  Stream<List<BookModel>> watchCachedBooks() {
    print('👀 [Cache] بدء مراقبة التغييرات في الكاش');
    return box.watch().map((event) {
      final books = box.values.toList();
      if (books.isNotEmpty) {
        print('🔄 [Cache] تغيير في الكاش: ${books.length} كتب');
      } else {
        print('⚠️ [Cache] الكاش أصبح فارغاً');
      }
      return books;
    });
  }
}
