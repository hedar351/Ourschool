import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Activities/data/model/activities_registrations_model.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';

ActivitiesRegistrationsModel _parseActivitiesRegistrations(
  String responseBody,
) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  return ActivitiesRegistrationsModel.fromJson(decoded);
}

abstract class ActivitiesRegistrationsRemoteDataSource {
  Future<Unit> approveRegistration(int activityId, int studentLocalNumber);
  Future<ActivitiesRegistrationsModel> getActivitiesRegistrations(
    int activityId,
  );
  Future<Unit> rejectRegistration(int activityId, int studentLocalNumber);
}

class ActivitiesRegistrationsRemoteDataSourceImpl
    implements ActivitiesRegistrationsRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  ActivitiesRegistrationsRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<Unit> approveRegistration(
    int activityId,
    int studentLocalNumber,
  ) async {
    print(
      ' [Activities Registrations Remote] قبول تسجيل الطالب رقم $studentLocalNumber في النشاط رقم $activityId',
    );

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Activities Registrations Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final response = await client.post(
      Uri.parse(
        '$baseUrl/activities/$activityId/registrations/$studentLocalNumber/approve',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(
      ' [Activities Registrations Remote] حالة الاستجابة: ${response.statusCode}',
    );
    print(' [Activities Registrations Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' [Activities Registrations Remote] تم قبول التسجيل بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل قبول التسجيل';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print(
        '🔴 [Activities Registrations Remote] فشل قبول التسجيل - $errorMessage',
      );
      throw ServerExp(message: errorMessage);
    }
  }

  @override
  Future<ActivitiesRegistrationsModel> getActivitiesRegistrations(
    int activityId,
  ) async {
    print(
      ' [Activities Registrations Remote] بدء جلب تسجيلات النشاط رقم $activityId',
    );

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Activities Registrations Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final response = await client.get(
      Uri.parse('$baseUrl/activities/$activityId/registrations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(
      ' [Activities Registrations Remote] حالة الاستجابة: ${response.statusCode}',
    );
    print(' [Activities Registrations Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200) {
      final registrations = await compute(
        _parseActivitiesRegistrations,
        response.body,
      );
      print(' [Activities Registrations Remote] تم جلب التسجيلات بنجاح');
      return registrations;
    } else {
      print('🔴 [Activities Registrations Remote] فشل جلب التسجيلات');
      throw ServerExp();
    }
  }

  @override
  Future<Unit> rejectRegistration(
    int activityId,
    int studentLocalNumber,
  ) async {
    print(
      ' [Activities Registrations Remote] رفض تسجيل الطالب رقم $studentLocalNumber في النشاط رقم $activityId',
    );

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Activities Registrations Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final response = await client.post(
      Uri.parse(
        '$baseUrl/activities/$activityId/registrations/$studentLocalNumber/reject',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(
      ' [Activities Registrations Remote] حالة الاستجابة: ${response.statusCode}',
    );
    print(' [Activities Registrations Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' [Activities Registrations Remote] تم رفض التسجيل بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل رفض التسجيل';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print(
        '🔴 [Activities Registrations Remote] فشل رفض التسجيل - $errorMessage',
      );
      throw ServerExp(message: errorMessage);
    }
  }
}
