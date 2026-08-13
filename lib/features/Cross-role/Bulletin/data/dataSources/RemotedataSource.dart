import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Bulletin/data/model/BulletinModel.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';

List<Bulletinmodel> _parseBulletins(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);
  if (decoded.containsKey('data') && decoded['data'] is List) {
    final List<dynamic> data = decoded['data'];
    return data
        .map((e) => Bulletinmodel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  final bulletin = Bulletinmodel.fromJson(decoded);
  return [bulletin];
}

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
    print('📰 [Remote] بدء جلب الإعلانات/النشرات من الـ API');

    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print('🔴 [Remote] No token found');
      throw TokenNotFoundExp();
    }

    final response = await client.get(
      Uri.parse('$baseUrl/feed'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('🟡 [Remote] Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final bulletins = await compute(_parseBulletins, response.body);
      print('✅ [Remote] تم جلب ${bulletins.length} نشرة بنجاح');
      return bulletins;
    } else {
      print('🔴 [Remote] فشل جلب النشرات');
      throw ServerExp();
    }
  }
}
