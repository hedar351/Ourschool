import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';

import '../../Model/TeacherStudentProfileModel/TeacherStudentProfileModel.dart';

abstract class RemoteTeacherStudentProfile {
  Future<TeacherStudentProfileModel> getTeacherStudentProfile(
    int localStudentNumber,
    int schoolId,
  );
}

class RemoteTeacherStudentProfileImpl implements RemoteTeacherStudentProfile {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RemoteTeacherStudentProfileImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<TeacherStudentProfileModel> getTeacherStudentProfile(
    int localStudentNumber,
    int schoolId,
  ) async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      throw TokenNotFoundExp();
    }

    final url = Uri.parse(
      '$baseUrl/teacher/students/$localStudentNumber/full-profile?schoolId=$schoolId',
    );
    print('🟡 [Remote] GET: $url');

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('🟡 [Remote] Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      print('✅ [Remote] Full response: $decoded');
      return TeacherStudentProfileModel.fromJson(decoded);
    } else {
      print('🔴 [Remote] Error: ${response.body}');
      throw ServerExp();
    }
  }
}
