// lib/features/Librarian/data/datasources/librarian_remote_data_source.dart

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Student/data/Model/LibraryModel/book_model.dart';

List<BookModel> _parseBooks(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  print(' [Librarian Remote] الرد المُفكك: $decoded');

  dynamic data = decoded['data']['books'];

  List<dynamic> bookList;

  if (data is List) {
    bookList = data;
  } else if (data is Map) {
    bookList = [data];
  } else {
    bookList = [];
  }

  return bookList
      .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
      .toList();
}

abstract class LibrarianRemoteDataSource {
  Future<Unit> addBooks(String title, String author, int copies);
  Future<List<BookModel>> getBooks();
}

class LibrarianRemoteDataSourceImpl implements LibrarianRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  LibrarianRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  // داخل LibrarianRemoteDataSourceImpl

  @override
  Future<Unit> addBooks(String title, String author, int copies) async {
    print(' [Librarian Remote] بدء إضافة كتاب جديد');
    print(
      ' [Librarian Remote] العنوان: $title, المؤلف: $author, النسخ: $copies',
    );

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Librarian Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final body = json.encode({
      'title': title,
      'author': author,
      'copies': copies,
    });

    final response = await client.post(
      Uri.parse('$baseUrl/librarian/books'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    print('[Librarian Remote] حالة الاستجابة: ${response.statusCode}');
    print('[Librarian Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' [Librarian Remote] تم إضافة الكتاب بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل إضافة الكتاب';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print('🔴 [Librarian Remote] فشل إضافة الكتاب - الرسالة: $errorMessage');
      throw ServerExp(message: errorMessage);
    }
  }

  @override
  Future<List<BookModel>> getBooks() async {
    print(' [Librarian Remote] بدء جلب الكتب من الـ API');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Librarian Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final response = await client.get(
      Uri.parse('$baseUrl/librarian/books'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('[Librarian Remote] حالة الاستجابة: ${response.statusCode}');
    print('[Librarian Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200) {
      final books = await compute(_parseBooks, response.body);
      print(' [Librarian Remote] تم جلب ${books.length} كتاب بنجاح');
      return books;
    } else {
      print(' [Librarian Remote] فشل جلب الكتب');
      throw ServerExp();
    }
  }
}
