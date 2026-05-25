import 'package:school/features/Auth/domain/entities/auth_entities.dart';

class AuthModel extends AuthEntities {
  const AuthModel({
    required super.username,
    required super.token,
    required super.role,
    required super.id,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final tokenObj = json['data'] ?? json;
    if (tokenObj is! Map<String, dynamic>) {
      throw Exception("Invalid token structure");
    }
    return AuthModel(
      username: tokenObj['username'] as String,
      token: tokenObj['token'] as String,
      role: tokenObj['role'] as String,
      id: tokenObj['userId'] as int?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'username': username,
        'token': token,
        'role': role,
        "userId": id,
      },
    };
  }
}
