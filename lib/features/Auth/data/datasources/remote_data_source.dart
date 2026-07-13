import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:school/features/Auth/data/model/auth_model.dart';

import '../../../../core/const.dart';
import '../../../../core/error/EXP.dart';

// abstract class AuthRemoteDataSources {
//   Future<AuthModel> remotelogin(String password, String username);
//   // Future<Unit> remoteLogout();
// }

// class AuthRemoteDataSourcesImp implements AuthRemoteDataSources {
//   final http.Client client;
//   AuthRemoteDataSourcesImp({required this.client});

//   @override
//   Future<AuthModel> remotelogin(String password, String username) async {
//     print("🔵 [Remote] remotelogin called with username: $username");
//     final body = {"email": username, "password": password};

//     try {
//       // final httpClient = HttpClient()
//       //   ..badCertificateCallback =
//       //       (X509Certificate cert, String host, int port) => true;
//       // final ioClient = IOClient(httpClient);

//       final url = Uri.parse("$baseUrl/auth/login");
//       print("🟡 [Remote] Sending POST request to $url");
//       final response = await client.post(
//         url,
//         body: json.encode(body),
//         headers: {"Content-Type": "application/json"},
//       );

//       print("🟡 [Remote] Response status code: ${response.statusCode}");

//       if (response.statusCode == 200) {
//         print("🟢 [Remote] Status 200 OK, decoding JSON");
//         final jsonBody = json.decode(response.body);
//         print("🟢 [Remote] JSON body: $jsonBody");

//         // if (jsonBody['success'] == true) {
//         // final userData = jsonBody['data'];
//         final user = AuthModel.fromJson(jsonBody);
//         print("🟢 [Remote] User model created: ${user.name}");
//         return user;
//         // } else {
//         //   print(
//         //     "🔴 [Remote] API returned success=false: ${jsonBody['message']}",
//         //   );
//         //   throw ServerExp();
//         // }
//       } else {
//         print("🔴 [Remote] Status code not 200: ${response.statusCode}");
//         throw ServerExp();
//       }
//     } on SocketException {
//       print("🔴 [Remote] SocketException - no internet or server unreachable");
//       throw OfflineExp();
//     } catch (e) {
//       print("🔴 [Remote] Unexpected error: $e");
//       throw ServerExp();
//     }
//   }
// }

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
      print("🟡 [Remote] Sending POST request to $url");
      final response = await ioClient.post(
        url,
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
      );

      print("🟡 [Remote] Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("🟢 [Remote] Status 200 OK, decoding JSON");
        final jsonBody = json.decode(response.body);
        print("🟢 [Remote] JSON body: $jsonBody");
        final user = AuthModel.fromJson(jsonBody);
        print("🟢 [Remote] User model created: ${user.name}");
        return user;
      } else {
        print("🔴 [Remote] Status code not 200: ${response.statusCode}");
        throw ServerExp();
      }
    } on SocketException {
      print("🔴 [Remote] SocketException - no internet or server unreachable");
      throw OfflineExp();
    } catch (e) {
      print("🔴 [Remote] Unexpected error: $e");
      throw ServerExp();
    }
  }
}
