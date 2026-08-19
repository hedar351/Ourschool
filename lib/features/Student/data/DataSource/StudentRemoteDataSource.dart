import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/StudentFullProfileModel.dart';

StudentFullProfileModel _parseStudentProfile(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  return StudentFullProfileModel.fromJson(decoded);
}

abstract class StudentRemoteDataSource {
  Future<Unit> deleteRegister(int activityId);
  Future<StudentFullProfileModel> getFullProfile();
  Future<Unit> register(int activityId);
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  StudentRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<Unit> deleteRegister(int activityId) async {
    print('🗑️ [Remote] بدء إلغاء التسجيل في النشاط رقم $activityId');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print(' [Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final url = Uri.parse(
      '$baseUrl/student/activities/registrations/$activityId',
    );
    print(' [Remote] إرسال طلب DELETE إلى: $url');

    final response = await client.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(' [Remote] حالة الاستجابة: ${response.statusCode}');
    print(' [Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      print(' [Remote] تم إلغاء التسجيل بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل إلغاء التسجيل';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print('🔴 [Remote] فشل الطلب: $errorMessage');
      throw ServerExp(message: errorMessage);
    }
  }

  @override
  Future<StudentFullProfileModel> getFullProfile() async {
    print('🟣 [Remote] بدء جلب الملف الشخصي من الـ API');

    final token = await authLocalDataSource.getToken();
    print(
      '🟣 [Remote] التوكن المسترجع: ${token.isNotEmpty ? 'موجود (${token.length} حرف)' : ' فارغ'}',
    );

    if (token.isEmpty) {
      print('🔴 [Remote] التوكن فارغ، رمي TokenNotFoundExp');
      throw TokenNotFoundExp();
    }

    final url = Uri.parse('$baseUrl/student/full-profile');
    print('🟣 [Remote] إرسال طلب إلى: $url');

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('🟡 [Remote] حالة الاستجابة: ${response.statusCode}');
    print(
      '🟡 [Remote] نص الرد: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...',
    );

    if (response.statusCode == 200) {
      print(
        '✅ [Remote] تم استقبال البيانات بنجاح، جاري المعالجة في Isolate مستقل...',
      );
      return compute(_parseStudentProfile, response.body);
    } else {
      print('🔴 [Remote] فشل الطلب، رمي ServerExp');
      throw ServerExp();
    }
  }

  // في StudentRemoteDataSourceImpl

  @override
  Future<Unit> register(int activityId) async {
    print(' [Remote] بدء التسجيل في النشاط رقم $activityId');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    final url = Uri.parse('$baseUrl/student/activities/$activityId/register');
    print(' [Remote] إرسال طلب POST إلى: $url');

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
      print('✅ [Remote] تم التسجيل بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل التسجيل';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print('🔴 [Remote] فشل الطلب - $errorMessage');
      throw ServerExp(message: errorMessage);
    }
  }
}
