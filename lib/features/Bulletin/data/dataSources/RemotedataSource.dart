import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Bulletin/data/model/BulletinModel.dart';

abstract class RemotedataSource {
  Future<List<Bulletinmodel>> getBulletins();
}

class RemoteDataSourceImp implements RemotedataSource {
  final http.Client client;

  RemoteDataSourceImp({required this.client});

  @override
  Future<List<Bulletinmodel>> getBulletins() async {
    final response = await client.get(
      Uri.parse('$baseUrl/bulletins'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      // final List decodeJson = json.decode(response.body);
      // final List<Bulletinmodel> models = decodeJson
      //     .map<Bulletinmodel>((jsonModel) => Bulletinmodel.fromJson(jsonModel))
      //     .toList();
      // return models;
      final Map<String, dynamic> decoded = json.decode(response.body);
      final bulletin = Bulletinmodel.fromJson(decoded);
      return [bulletin];
    } else {
      throw ServerExp();
    }
  }
}
