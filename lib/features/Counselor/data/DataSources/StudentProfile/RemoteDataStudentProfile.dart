// abstract class Remotedatastudentprofile {}

// class RemotedatastudentprofileImp implements Remotedatastudentprofile {}
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_studentFullProfileModel.dart';

CounselorStudentFullProfileModel _parseCounselorStudentProfile(
  String responseBody,
) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  return CounselorStudentFullProfileModel.fromJson(decoded);
}

abstract class RemoteDataStudentProfile {
  Future<CounselorStudentFullProfileModel> getStudentProfile(
    int localStudentNumber,
  );
}

class RemoteDataStudentProfileImp implements RemoteDataStudentProfile {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RemoteDataStudentProfileImp({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<CounselorStudentFullProfileModel> getStudentProfile(
    int localStudentNumber,
  ) async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print("🔴 [Remote] No token found");
      throw TokenNotFoundExp();
    }

    final response = await client.get(
      Uri.parse('$baseUrl/counselor/students/$localStudentNumber/full-profile'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🟡 [Remote] Response status: ${response.statusCode}");
    print("🟡 [Remote] Response body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      print("🟡 [Remote] Decoded JSON: $decoded");

      return compute(_parseCounselorStudentProfile, response.body);
    } else {
      throw ServerExp();
    }
  }
}
