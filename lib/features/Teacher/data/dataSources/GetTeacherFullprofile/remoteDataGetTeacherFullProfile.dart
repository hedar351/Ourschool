import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Teacher/data/Model/TeacherFullProfileModel.dart';

abstract class RemoteDataTeacherFullProfile {
  Future<TeacherFullProfileModel> getTeacherFullProfile();
}

class RemoteDataTeacherFullProfileImp implements RemoteDataTeacherFullProfile {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RemoteDataTeacherFullProfileImp({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<TeacherFullProfileModel> getTeacherFullProfile() async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print("🔴 [Remote] No token found");
      throw TokenNotFoundExp();
    }

    final response = await client.get(
      Uri.parse('$baseUrl/teacher/full-profile'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🟡 [Remote] Response status: ${response.statusCode}");
    print("🟡 [Remote] Response body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      return TeacherFullProfileModel.fromJson(decoded);
    } else {
      throw ServerExp();
    }
  }
}
