import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/EXP.dart';
import '../model/auth_model.dart';

const authCacheKey = "AUTH_CACHE";

abstract class AuthLocalDataSource {
  Future<Unit> cacheUser(AuthModel user);
  Future<Unit> deleteUser();
  Future<AuthModel> getUser();
}

class AuthLocalDataSourceImp implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> cacheUser(AuthModel user) {
    print("🟡 [Local] cacheUser called for user: ${user.name}");
    final Map<String, dynamic> userJson = user.toJson();
    final String jsonString = json.encode(userJson);
    sharedPreferences.setString(authCacheKey, jsonString);
    print("🟢 [Local] User cached successfully");
    return Future.value(unit);
  }

  @override
  Future<Unit> deleteUser() async {
    print("🟡 [Local] deleteUser called");
    await sharedPreferences.remove(authCacheKey);
    print("🟢 [Local] User deleted from cache");
    return Future.value(unit);
  }

  @override
  Future<AuthModel> getUser() {
    print("🟡 [Local] getUser called");
    final jsonString = sharedPreferences.getString(authCacheKey);
    if (jsonString != null) {
      print("🟢 [Local] Cache found, decoding JSON");
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final AuthModel user = AuthModel.fromJson(jsonMap);
      print("🟢 [Local] User retrieved: ${user.name}${user.schoolId}");
      return Future.value(user);
    } else {
      print("🔴 [Local] No cache found, throwing EmptyCacheExp");
      throw EmptyCacheExp();
    }
  }
}
