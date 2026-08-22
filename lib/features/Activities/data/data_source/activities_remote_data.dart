import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';

abstract class ActivitiesRemoteData {
  Future<Unit> addActivities(
    String title,
    String description,
    String expiryDate,
  );
  Future<Unit> deleteActivities(int localActivityId);
  Future<Unit> editActivities(
    int localActivityId,
    String title,
    String description,
    String expiryDate,
  );
}

class ActivitiesRemoteDataImp implements ActivitiesRemoteData {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  ActivitiesRemoteDataImp({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<Unit> addActivities(
    String title,
    String description,
    String expiryDate,
  ) async {
    print(' [Activities Remote] بدء إضافة نشاط جديد');
    // print(' [Activities Remote] العنوان: $title');
    // print(' [Activities Remote] الوصف: $description');
    // print(' [Activities Remote] تاريخ الانتهاء: $expiryDate');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Activities Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }

    String formattedExpiryDate = expiryDate;
    try {
      final parsedDate = DateTime.parse(expiryDate);
      formattedExpiryDate =
          '${parsedDate.year}-'
          '${parsedDate.month.toString().padLeft(2, '0')}-'
          '${parsedDate.day.toString().padLeft(2, '0')}'
          'T${parsedDate.hour.toString().padLeft(2, '0')}:'
          '${parsedDate.minute.toString().padLeft(2, '0')}:'
          '${parsedDate.second.toString().padLeft(2, '0')}.000Z';
    } catch (e) {
      print('⚠️ [Activities Remote] فشل تحليل التاريخ: $e');
    }

    final body = json.encode({
      'title': title.trim(),
      'description': description.trim(),
      'expiryDate': formattedExpiryDate,
    });

    final url = Uri.parse('$baseUrl/activities');

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    print(' [Activities Remote] حالة الاستجابة: ${response.statusCode}');
    print(' [Activities Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' [Activities Remote] تم إضافة النشاط بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل إضافة النشاط';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print('🔴 [Activities Remote] فشل إضافة النشاط - الرسالة: $errorMessage');
      throw ServerExp(message: errorMessage);
    }
  }
  // @override
  // Future<Unit> addActivities(
  //   String title,
  //   String description,
  //   String expiryDate,
  // ) async {
  //   print(' [Activities Remote] بدء إضافة نشاط جديد');
  //   print(' [Activities Remote] العنوان: $title');
  //   print(' [Activities Remote] الوصف: $description');
  //   print(' [Activities Remote] تاريخ الانتهاء: $expiryDate');
  //   final token = await authLocalDataSource.getToken();
  //   if (token.isEmpty) {
  //     print('🔴 [Activities Remote] التوكن فارغ');
  //     throw TokenNotFoundExp();
  //   }
  //   final body = json.encode({
  //     'title': title,
  //     'description': description,
  //     'expiryDate': expiryDate,
  //   });
  //   print(' [Activities Remote] الـ Body المرسل: $body');
  //   final response = await client.post(
  //     Uri.parse('$baseUrl/activities'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //     body: body,
  //   );
  //   print(' [Activities Remote] حالة الاستجابة: ${response.statusCode}');
  //   print(' [Activities Remote] نص الرد: ${response.body}');
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print(' [Activities Remote] تم إضافة النشاط بنجاح');
  //     return unit;
  //   } else {
  //     String errorMessage = 'فشل إضافة النشاط';
  //     try {
  //       final Map<String, dynamic> decoded = json.decode(response.body);
  //       errorMessage = decoded['message'] as String? ?? errorMessage;
  //     } catch (_) {}
  //     print('🔴 [Activities Remote] فشل إضافة النشاط - الرسالة: $errorMessage');
  //     throw ServerExp(message: errorMessage);
  //   }
  // }

  @override
  Future<Unit> deleteActivities(int localActivityId) async {
    print(' [Activities Remote] بدء حذف النشاط رقم $localActivityId');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Activities Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }
    print(localActivityId);
    final response = await client.delete(
      Uri.parse('$baseUrl/activities/$localActivityId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(' [Activities Remote] حالة الاستجابة: ${response.statusCode}');
    print(' [Activities Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 204) {
      print(' [Activities Remote] تم حذف النشاط بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل حذف النشاط';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print('🔴 [Activities Remote] فشل حذف النشاط - الرسالة: $errorMessage');
      throw ServerExp(message: errorMessage);
    }
  }

  @override
  Future<Unit> editActivities(
    int localActivityId,
    String title,
    String description,
    String expiryDate,
  ) async {
    print(' [Activities Remote] بدء تعديل النشاط رقم $localActivityId');
    print(
      ' [Activities Remote] العنوان: $title, الوصف: $description, تاريخ الانتهاء: $expiryDate',
    );

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Activities Remote] التوكن فارغ');
      throw TokenNotFoundExp();
    }
    String formattedExpiryDate = expiryDate;
    try {
      final parsedDate = DateTime.parse(expiryDate);
      formattedExpiryDate =
          '${parsedDate.year}-'
          '${parsedDate.month.toString().padLeft(2, '0')}-'
          '${parsedDate.day.toString().padLeft(2, '0')}'
          'T${parsedDate.hour.toString().padLeft(2, '0')}:'
          '${parsedDate.minute.toString().padLeft(2, '0')}:'
          '${parsedDate.second.toString().padLeft(2, '0')}.000Z';
    } catch (e) {
      print('⚠️ [Activities Remote] فشل تحليل التاريخ: $e');
    }
    final body = json.encode({
      'title': title,
      'description': description,
      'expiryDate': formattedExpiryDate,
    });

    final response = await client.put(
      Uri.parse('$baseUrl/activities/$localActivityId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    print(' [Activities Remote] حالة الاستجابة: ${response.statusCode}');
    print(' [Activities Remote] نص الرد: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' [Activities Remote] تم تعديل النشاط بنجاح');
      return unit;
    } else {
      String errorMessage = 'فشل تعديل النشاط';
      try {
        final Map<String, dynamic> decoded = json.decode(response.body);
        errorMessage = decoded['message'] as String? ?? errorMessage;
      } catch (_) {}
      print('🔴 [Activities Remote] فشل تعديل النشاط - الرسالة: $errorMessage');
      throw ServerExp(message: errorMessage);
    }
  }
}
