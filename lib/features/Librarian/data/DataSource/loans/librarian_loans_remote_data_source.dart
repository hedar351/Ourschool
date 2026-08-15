import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_loans_model.dart';

LibrarianLoansModel _parseLibrarianLoans(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  return LibrarianLoansModel.fromJson(decoded);
}

abstract class LibrarianLoansRemoteDataSource {
  Future<LibrarianLoansModel> getLibrarianLoans({String? status});
}

class LibrarianLoansRemoteDataSourceImpl
    implements LibrarianLoansRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  LibrarianLoansRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<LibrarianLoansModel> getLibrarianLoans({String? status}) async {
    print(' [Librarian Loans Remote] بدء جلب استعارات أمين المكتبة');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Librarian Loans Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final uri = Uri.parse(
      '$baseUrl/librarian/loans',
    ).replace(queryParameters: status != null ? {'status': status} : null);

    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('[Librarian Loans Remote] حالة الاستجابة: ${response.statusCode}');
    print('[Librarian Loans Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200) {
      final loans = await compute(_parseLibrarianLoans, response.body);
      print('[Librarian Loans Remote] تم جلب الاستعارات بنجاح');
      return loans;
    } else {
      print(' [Librarian Loans Remote] فشل جلب الاستعارات');
      throw ServerExp();
    }
  }
}
