import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Counselor/data/Model/scheduleImageModel/GetscheduleImageModel.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';

abstract class RemoteDataTeacherScheduleImage {
  Future<GetscheduleImageModel> getTecherScheduleImage(int schoolId);
}

class RemoteDataTeacherScheduleImageImp
    implements RemoteDataTeacherScheduleImage {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RemoteDataTeacherScheduleImageImp({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<GetscheduleImageModel> getTecherScheduleImage(int schoolId) async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print("🔴 [Remote] No token found");
      throw TokenNotFoundExp();
    }

    final url = Uri.parse(
      "$baseUrl/teacher/schedule-image",
    ).replace(queryParameters: {'schoolId': schoolId.toString()});
    print("🟡 [Remote] GET schedule image: $url");

    final response = await client.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🟡 [Remote] GET status: ${response.statusCode}");
    print("🟡 [Remote] GET body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);

      final Map<String, dynamic> data =
          decoded['data'] as Map<String, dynamic>? ?? {};

      print("🟡 [Remote] Extracted data: $data");

      return GetscheduleImageModel.fromJson(data);
    } else {
      throw ServerExp();
    }
  }
}
