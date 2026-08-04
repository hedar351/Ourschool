// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:school/core/const.dart';
// import 'package:school/core/error/EXP.dart';
// import 'package:school/features/Auth/data/datasources/local_data_source.dart';
// import 'package:school/features/Bulletin/data/model/BulletinModel.dart';

// abstract class RemotedataSourceBulletin {
//   Future<List<Bulletinmodel>> getBulletins();
// }

// class RemoteDataSourceImpBulletin implements RemotedataSourceBulletin {
//   final http.Client client;
//   final AuthLocalDataSource authLocalDataSource;

//   RemoteDataSourceImpBulletin({
//     required this.client,
//     required this.authLocalDataSource,
//   });

//   @override
//   Future<List<Bulletinmodel>> getBulletins() async {
//     final token = await authLocalDataSource.getToken();
//     // final token = user.token;
//     if (token.isEmpty) {
//       print("🔴 [Remote] No token found");
//       throw TokenNotFoundExp();
//     }
//     final response = await client.get(
//       Uri.parse('$baseUrl/feed'),
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $token",
//       },
//     );
//     print("🟡 [Remote] Response status: ${response.statusCode}");
//     print("🟡 [Remote] Response body: ${response.body}");
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> decoded = json.decode(response.body);
//       final bulletin = Bulletinmodel.fromJson(decoded);
//       return [bulletin];
//     } else {
//       throw ServerExp();
//     }
//   }
// }
// lib/features/Bulletin/data/datasources/remote_data_source_bulletin.dart

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Bulletin/data/model/BulletinModel.dart';

// 💡 دالة التفكيك Top-level Function لتشغيلها داخل compute
List<Bulletinmodel> _parseBulletins(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);

  // إذا كانت الاستجابة تحتوي على قائمة داخل key معين مثل 'data'
  if (decoded.containsKey('data') && decoded['data'] is List) {
    final List<dynamic> data = decoded['data'];
    return data
        .map((e) => Bulletinmodel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // إذا كانت الاستجابة عبارة عن كائن واحد فقط وتريد إرجاعه كـ List
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
      // ✅ تحويل البيانات في Isolate منفصل لضمان أقصى سلاسة للـ UI
      final bulletins = await compute(_parseBulletins, response.body);
      print('✅ [Remote] تم جلب ${bulletins.length} نشرة بنجاح');
      return bulletins;
    } else {
      print('🔴 [Remote] فشل جلب النشرات');
      throw ServerExp();
    }
  }
}
