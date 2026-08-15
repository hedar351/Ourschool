// lib/features/Librarian/data/datasources/librarian_reservations_remote_data_source.dart

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_reservations_model.dart';

LibrarianReservationsModel _parseLibrarianReservations(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  return LibrarianReservationsModel.fromJson(decoded);
}

abstract class LibrarianReservationsRemoteDataSource {
  Future<LibrarianReservationsModel> getLibrarianReservations({String? status});
}

class LibrarianReservationsRemoteDataSourceImpl
    implements LibrarianReservationsRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  LibrarianReservationsRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<LibrarianReservationsModel> getLibrarianReservations({
    String? status,
  }) async {
    print(' [Librarian Reservations Remote] بدء جلب حجوزات أمين المكتبة');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Librarian Reservations Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final uri = Uri.parse(
      '$baseUrl/librarian/reservations',
    ).replace(queryParameters: status != null ? {'status': status} : null);

    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(
      ' [Librarian Reservations Remote] حالة الاستجابة: ${response.statusCode}',
    );
    print(' [Librarian Reservations Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200) {
      final reservations = await compute(
        _parseLibrarianReservations,
        response.body,
      );
      print('✅ [Librarian Reservations Remote] تم جلب الحجوزات بنجاح');
      return reservations;
    } else {
      print('🔴 [Librarian Reservations Remote] فشل جلب الحجوزات');
      throw ServerExp();
    }
  }
}
