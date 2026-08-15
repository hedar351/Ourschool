import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Librarian/data/Model/Book-reservations-loans-Model/book_reservations_model.dart';

BookReservationsModel _parseBookReservations(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  return BookReservationsModel.fromJson(decoded);
}

abstract class BookReservationsRemoteDataSource {
  Future<BookReservationsModel> getBookReservations({
    required String status,
    required int localBookNumber,
  });
}

class BookReservationsRemoteDataSourceImpl
    implements BookReservationsRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  BookReservationsRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<BookReservationsModel> getBookReservations({
    required String status,
    required int localBookNumber,
  }) async {
    print(
      ' [BookReservations Remote] بدء جلب حجوزات الكتاب رقم $localBookNumber',
    );

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [BookReservations Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final uri = Uri.parse(
      '$baseUrl/librarian/reservations/book/$localBookNumber',
    ).replace(queryParameters: {'status': status});

    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(' [BookReservations Remote] حالة الاستجابة: ${response.statusCode}');
    print(' [BookReservations Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200) {
      final reservations = await compute(_parseBookReservations, response.body);
      print('✅ [BookReservations Remote] تم جلب حجوزات الكتاب بنجاح');
      return reservations;
    } else {
      print('🔴 [BookReservations Remote] فشل جلب حجوزات الكتاب');
      throw ServerExp();
    }
  }
}
