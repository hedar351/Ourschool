// // lib/features/Student/data/datasources/StudentRemoteDataSource.dart

// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:school/core/const.dart';
// import 'package:school/core/error/EXP.dart';
// import 'package:school/features/Auth/data/datasources/local_data_source.dart';
// import 'package:school/features/Student/data/Model/StudentFullProfileModel.dart';

// abstract class StudentRemoteDataSource {
//   Future<StudentFullProfileModel> getFullProfile();
// }

// class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
//   final http.Client client;
//   final AuthLocalDataSource authLocalDataSource;

//   StudentRemoteDataSourceImpl({
//     required this.client,
//     required this.authLocalDataSource,
//   });

//   @override
//   Future<StudentFullProfileModel> getFullProfile() async {
//     final token = await authLocalDataSource.getToken();
//     if (token.isEmpty) {
//       throw TokenNotFoundExp();
//     }

//     final response = await client.get(
//       Uri.parse('$baseUrl/student/full-profile'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> decoded = json.decode(response.body);
//       return StudentFullProfileModel.fromJson(decoded);
//     } else {
//       throw ServerExp();
//     }
//   }
// }
// lib/features/Student/data/datasources/StudentRemoteDataSource.dart

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Student/data/Model/StudentFullProfileModel.dart';

abstract class StudentRemoteDataSource {
  Future<StudentFullProfileModel> getFullProfile();
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  StudentRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<StudentFullProfileModel> getFullProfile() async {
    print('🟣 [Remote] بدء جلب الملف الشخصي من الـ API');

    final token = await authLocalDataSource.getToken();
    print(
      '🟣 [Remote] التوكن المسترجع: ${token.isNotEmpty ? 'موجود (${token.length} حرف)' : '❌ فارغ'}',
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
      print('✅ [Remote] تم استقبال البيانات بنجاح');
      final Map<String, dynamic> decoded = json.decode(response.body);
      return StudentFullProfileModel.fromJson(decoded);
    } else {
      print('🔴 [Remote] فشل الطلب، رمي ServerExp');
      throw ServerExp();
    }
  }
}
