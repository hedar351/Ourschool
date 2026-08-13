import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:school/features/FirstStep/Auth/data/model/auth_model.dart';

import '../../../../../core/const.dart';
import '../../../../../core/error/EXP.dart';

abstract class AuthRemoteDataSources {
  Future<AuthModel> remotelogin(String password, String username);
}

class AuthRemoteDataSourcesImp implements AuthRemoteDataSources {
  final http.Client client;
  AuthRemoteDataSourcesImp({required this.client});

  @override
  Future<AuthModel> remotelogin(String password, String username) async {
    print("🔵 [Remote] remotelogin called with username: $username");
    final body = {"email": username, "password": password};

    try {
      final httpClient = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      final ioClient = IOClient(httpClient);

      final url = Uri.parse("$baseUrl/auth/login");
      final response = await ioClient.post(
        url,
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);

        final user = AuthModel.fromJson(jsonBody);
        return user;
      } else {
        String errorMessage = 'فشل تسجيل الدخول';
        final Map<String, dynamic> decoded = json.decode(response.body);

        errorMessage = decoded['message'] as String? ?? errorMessage;

        throw ServerExp(message: errorMessage);
      }
    } on SocketException {
      throw OfflineExp();
    }
  }
}
