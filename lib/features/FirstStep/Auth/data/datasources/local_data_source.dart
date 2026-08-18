import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/EXP.dart';
import '../model/auth_model.dart';

const authCacheKey = "AUTH_CACHE";
const authTokenKey = "Token_cache";

abstract class AuthLocalDataSource {
  Future<Unit> cacheToken(String token);
  Future<Unit> cacheUser(AuthModel user);
  Future<Unit> deleteToken();
  Future<Unit> deleteUser();
  Future<String> getToken();
  Future<AuthModel> getUser();
}

class AuthLocalDataSourceImp implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<Unit> cacheToken(String token) async {
    print("🟡 [Local] cacheToken called");
    await sharedPreferences.setString(authTokenKey, token);
    print("🟢 [Local] Token cached successfully");
    return unit;
  }

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
  Future<Unit> deleteToken() async {
    print("🟡 [Local] deletetoken called");
    await sharedPreferences.remove(authTokenKey);
    print("🟢 [Local] token deleted from cache");
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
  Future<String> getToken() async {
    print("🟡 [Local] getToken called");
    final token = sharedPreferences.getString(authTokenKey);
    if (token != null && token.isNotEmpty) {
      print("🟢 [Local] Token found");
      return token;
    } else {
      print("🔴 [Local] No token found");
      throw EmptyCacheExp();
    }
  }

  @override
  Future<AuthModel> getUser() {
    final jsonString = sharedPreferences.getString(authCacheKey);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final AuthModel user = AuthModel.fromJson(jsonMap);
      print("🟢 [Local] User retrieved: ${user.name}");
      return Future.value(user);
    } else {
      print("🔴 [Local] No cache found, throwing EmptyCacheExp");
      throw EmptyCacheExp();
    }
  }
}
