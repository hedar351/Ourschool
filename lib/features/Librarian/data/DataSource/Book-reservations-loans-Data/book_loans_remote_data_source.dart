import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Librarian/data/Model/Book-reservations-loans-Model/book_loan_model.dart';

BookLoanModel _parseBookLoans(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  return BookLoanModel.fromJson(decoded);
}

abstract class BookLoansRemoteDataSource {
  Future<BookLoanModel> getBookLoans(int localBookNumber);
}

class BookLoansRemoteDataSourceImpl implements BookLoansRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  BookLoansRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<BookLoanModel> getBookLoans(int localBookNumber) async {
    print(' [BookLoans Remote] بدء جلب استعارات الكتاب رقم $localBookNumber');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [BookLoans Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final uri = Uri.parse('$baseUrl/librarian/loans/book/$localBookNumber');

    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(' [BookLoans Remote] حالة الاستجابة: ${response.statusCode}');
    print(' [BookLoans Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200) {
      final loans = await compute(_parseBookLoans, response.body);
      print(' [BookLoans Remote] تم جلب استعارات الكتاب بنجاح');
      return loans;
    } else {
      print('🔴 [BookLoans Remote] فشل جلب استعارات الكتاب');
      throw ServerExp();
    }
  }
}
