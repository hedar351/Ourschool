import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_WarningsModel.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';

abstract class Remotedatapostwarnings {
  Future<CounselorWarningModel> warnings(
    int localStudentNumber,
    String type,
    String reason,
  );
}

class RemotedatapostwarningsImp implements Remotedatapostwarnings {
  final AuthLocalDataSource authLocalDataSource;
  final http.Client client;

  RemotedatapostwarningsImp({
    required this.authLocalDataSource,
    required this.client,
  });

  @override
  Future<CounselorWarningModel> warnings(
    int localStudentNumber,
    String type,
    String reason,
  ) async {
    final body = json.encode({
      'localStudentNumber': localStudentNumber,
      'type': type,
      'reason': reason,
    });
    print("🟡 [Remote] Request body: $body");

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print("🔴 [Remote] No token found");
      throw TokenNotFoundExp();
    }

    print("🟡 [Remote] Token found: ${token.substring(0, 20)}...");

    final url = Uri.parse("$baseUrl/counselor/warnings");
    print("🟡 [Remote] Sending POST to $url");

    final response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );

    print("🟡 [Remote] Response status: ${response.statusCode}");
    print("🟡 [Remote] Response body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      final model = CounselorWarningModel.fromJson(decoded);
      return model;
    } else {
      try {
        final errorBody = json.decode(response.body);
        print("🔴 [Remote] Error response: $errorBody");
      } catch (_) {
        print("🔴 [Remote] Could not decode error body");
      }
      throw ServerExp();
    }
  }
}
