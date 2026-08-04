import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Counselor/data/Model/StudentsBySectionModel/StudentsBySectionModel.dart';

Studentsbysectionmodel _parseStudentsBySection(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  return Studentsbysectionmodel.fromJson(decoded);
}

abstract class Remotedatateacherstudentslist {
  Future<Studentsbysectionmodel> getStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  );
}

class RemotedatateacherstudentslistImp
    implements Remotedatateacherstudentslist {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RemotedatateacherstudentslistImp({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<Studentsbysectionmodel> getStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  ) async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print("🔴 [Remote] No token found");
      throw TokenNotFoundExp();
    }

    final response = await client.get(
      Uri.parse(
        // "$baseUrl/teacher/sections/$localGradeNumber/$localSectionNumber/$localSubjectId/students",
        "$baseUrl/teacher/sections/$localGradeNumber/$localSectionNumber/students?localSubjectId=$localSubjectId&schoolId=$schoolId",
      ),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🟡 [Remote] Response status: ${response.statusCode}");
    print("🟡 [Remote] Response body: ${response.body}");

    if (response.statusCode == 200) {
      // final Map<String, dynamic> decoded = json.decode(response.body);
      return compute(_parseStudentsBySection, response.body);
    } else {
      throw ServerExp();
    }
  }
}
