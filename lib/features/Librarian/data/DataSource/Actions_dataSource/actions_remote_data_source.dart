import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';

abstract class ActionsRemoteDataSource {
  Future<Unit> approve(int localBookNumber, int localStudentNumber);
  Future<Unit> postLoans(int localBookNumber, int localStudentNumber);
  Future<Unit> reject(int localBookNumber, int localStudentNumber);
  Future<Unit> returnLoans(int localBookNumber, int localStudentNumber);
}

class ActionsRemoteDataSourceImp implements ActionsRemoteDataSource {
  final AuthLocalDataSource authLocalDataSource;
  final http.Client client;

  ActionsRemoteDataSourceImp({
    required this.authLocalDataSource,
    required this.client,
  });

  @override
  Future<Unit> approve(int localBookNumber, int localStudentNumber) async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Librarian Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }
    final response = await client.put(
      Uri.parse(
        "$baseUrl/librarian/reservations/$localBookNumber/$localStudentNumber/approve",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' [Librarian Remote] تم قبول حجز الكتاب بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل قبول حجز الكتاب';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print(
        '🔴 [Librarian Remote] فشل قبول حجز الكتاب - الرسالة: $errorMessage',
      );
      throw ServerExp(message: errorMessage);
    }
  }

  @override
  Future<Unit> postLoans(int localBookNumber, int localStudentNumber) async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Librarian Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final response = await client.post(
      Uri.parse("$baseUrl/librarian/loans").replace(
        queryParameters: {
          'localBookNumber': localBookNumber.toString(),
          'localStudentNumber': localStudentNumber.toString(),
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' [Librarian Remote] تم إنشاء الإعارة بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل إنشاء الإعارة';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print('🔴 [Librarian Remote] فشل إنشاء الإعارة - الرسالة: $errorMessage');
      throw ServerExp(message: errorMessage);
    }
  }

  @override
  Future<Unit> reject(int localBookNumber, int localStudentNumber) async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Librarian Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }
    final response = await client.put(
      Uri.parse(
        "$baseUrl/librarian/reservations/$localBookNumber/$localStudentNumber/reject",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' [Librarian Remote] تم رفض حجز الكتاب بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل رفض حجز الكتاب';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print(
        '🔴 [Librarian Remote] فشل رفض حجز الكتاب - الرسالة: $errorMessage',
      );
      throw ServerExp(message: errorMessage);
    }
  }

  @override
  Future<Unit> returnLoans(int localBookNumber, int localStudentNumber) async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Librarian Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final response = await client.post(
      Uri.parse("$baseUrl/librarian/loans/return").replace(
        queryParameters: {
          'localBookNumber': localBookNumber.toString(),
          'localStudentNumber': localStudentNumber.toString(),
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' [Librarian Remote] تم إرجاع الكتاب بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل إرجاع الكتاب';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print('🔴 [Librarian Remote] فشل إرجاع الكتاب - الرسالة: $errorMessage');
      throw ServerExp(message: errorMessage);
    }
  }
}
