import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Student/data/Model/LibraryModel/book_model.dart';
import 'package:school/features/Student/data/Model/LibraryModel/reservations_model.dart';
import 'package:school/features/Student/data/Model/LibraryModel/reserve_model.dart';

List<BookModel> _parseBooks(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  final List<dynamic> data = decoded['data'] as List? ?? [];
  return data
      .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
      .toList();
}

ReservationsModel _parseReservations(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  return ReservationsModel.fromJson(decoded);
}

abstract class LibraryRemoteDataSource {
  Future<List<BookModel>> getBooks();
  Future<ReservationsModel> getReservations();
  Future<ReserveModel> reserveBook(int localBookNumber);
}

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  LibraryRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<List<BookModel>> getBooks() async {
    print(' [Remote] بدء جلب الكتب من الـ API');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print(' [Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final response = await client.get(
      Uri.parse('$baseUrl/student/library/books'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('[Remote] حالة الاستجابة: ${response.statusCode}');

    if (response.statusCode == 200) {
      final books = await compute(_parseBooks, response.body);
      print(' [Remote] تم جلب ${books.length} كتاب بنجاح');
      return books;
    } else {
      print(' [Remote] فشل جلب الكتب');
      throw ServerExp();
    }
  }

  // ============================================================
  // ====== GET RESERVATIONS ======
  // ============================================================

  @override
  Future<ReservationsModel> getReservations() async {
    print(' [Remote] بدء جلب الحجوزات من الـ API');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print(' [Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final response = await client.get(
      Uri.parse('$baseUrl/student/library/reservations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(' [Remote] حالة الاستجابة: ${response.statusCode}');
    print(' [Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200) {
      final reservations = await compute(_parseReservations, response.body);
      print(' [Remote] تم جلب الحجوزات بنجاح');
      return reservations;
    } else {
      print(' [Remote] فشل جلب الحجوزات');
      throw ServerExp();
    }
  }

  @override
  Future<ReserveModel> reserveBook(int localBookNumber) async {
    print(' [Remote] بدء حجز الكتاب رقم: $localBookNumber');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print(' [Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final url = Uri.parse(
      '$baseUrl/student/library/books/$localBookNumber/reserve',
    );

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(' [Remote] حالة الاستجابة: ${response.statusCode}');
    print(' [Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      print(' [Remote] تم حجز الكتاب بنجاح');
      return ReserveModel.fromJson(decoded);
    } else {
      String errorMessage = 'فشل حجز الكتاب';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}

      print(' [Remote] فشل حجز الكتاب - الرسالة: $errorMessage');
      throw ServerExp(message: errorMessage);
    }
  }
}
