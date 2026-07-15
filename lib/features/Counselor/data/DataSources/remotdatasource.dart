import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Counselor/data/Model/gradeandSectionModel/gradeModel.dart';

abstract class RemotdatasourceGrade {
  Future<List<GradeModel>> getGardeAndSection();
}

class RemotedatasourceImpGrade implements RemotdatasourceGrade {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RemotedatasourceImpGrade({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<List<GradeModel>> getGardeAndSection() async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print("🔴 [Remote] No token found");
      throw TokenNotFoundExp();
    }
    final response = await client.get(
      Uri.parse("$baseUrl/counselor/sections"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    print("🟡 [Remote] Response status: ${response.statusCode}");
    print("🟡 [Remote] Response body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);

      final grades = decoded.map((e) => GradeModel.fromJson(e)).toList();
      return grades;
    } else {
      throw ServerExp();
    }
  }
}
