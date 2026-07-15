import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Bulletin/data/model/BulletinModel.dart';

abstract class RemotedataSourceBulletin {
  Future<List<Bulletinmodel>> getBulletins();
}

class RemoteDataSourceImpBulletin implements RemotedataSourceBulletin {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RemoteDataSourceImpBulletin({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<List<Bulletinmodel>> getBulletins() async {
    final token = await authLocalDataSource.getToken();
    // final token = user.token;
    if (token.isEmpty) {
      print("🔴 [Remote] No token found");
      throw TokenNotFoundExp();
    }
    final response = await client.get(
      Uri.parse('$baseUrl/feed'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    print("🟡 [Remote] Response status: ${response.statusCode}");
    print("🟡 [Remote] Response body: ${response.body}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      final bulletin = Bulletinmodel.fromJson(decoded);
      return [bulletin];
    } else {
      throw ServerExp();
    }
  }
}
