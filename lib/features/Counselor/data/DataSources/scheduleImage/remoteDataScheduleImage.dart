import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Counselor/data/Model/scheduleImageModel/GetscheduleImageModel.dart';

abstract class Remotedatascheduleimage {
  Future<GetscheduleImageModel> getscheduleImage(
    int localGradeNumber,
    int localSectionNumber,
  );
}

class RemotedatascheduleimageImpl implements Remotedatascheduleimage {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RemotedatascheduleimageImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<GetscheduleImageModel> getscheduleImage(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print("🔴 [Remote] No token found");
      throw TokenNotFoundExp();
    }

    final url = Uri.parse(
      "$baseUrl/counselor/schedule-images/section/$localGradeNumber/$localSectionNumber",
    );
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
      return GetscheduleImageModel.fromJson(decoded);
    } else {
      throw ServerExp();
    }
  }
}
