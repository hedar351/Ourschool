import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Counselor/data/Model/gradeandSectionModel/gradeModel.dart';

abstract class Remotdatasource {
  Future<List<GradeModel>> getGardeAndSection();
}

class RemotedatasourceImp implements Remotdatasource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RemotedatasourceImp({
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
      Uri.parse("$baseUrl/sections"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    print("🟡 [Remote] Response status: ${response.statusCode}");
    print("🟡 [Remote] Response body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);

      final grade = GradeModel.fromJson(decoded);
      return [grade];
    } else {
      throw ServerExp();
    }
  }
}
