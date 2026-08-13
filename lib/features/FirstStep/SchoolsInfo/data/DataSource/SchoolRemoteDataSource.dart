// lib/features/SchoolsInfo/data/datasources/school_remote_ds.dart

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/FirstStep/SchoolsInfo/data/models/SchoolWithTeacherModel.dart';

abstract class SchoolRemoteDataSource {
  Future<SchoolWithTeacherModel> getSchoolsWithTeachers();
}

class SchoolRemoteDataSourceImpl implements SchoolRemoteDataSource {
  final http.Client client;
  SchoolRemoteDataSourceImpl({required this.client});

  @override
  Future<SchoolWithTeacherModel> getSchoolsWithTeachers() async {
    final response = await client.get(
      Uri.parse('$baseUrl/schools'),
      headers: {"Content-Type": "application/json"},
    );

    print("🟡 [Remote] Response status: ${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      print(" $decoded");

      return SchoolWithTeacherModel.fromJson(decoded);
    } else {
      print("🔴 [Remote] Error: ${response.body}");
      throw ServerExp();
    }
  }
}
