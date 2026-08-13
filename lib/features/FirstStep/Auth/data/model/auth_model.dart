import 'package:school/features/FirstStep/Auth/domain/entities/auth_entities.dart';

class AuthModel extends AuthEntities {
  const AuthModel({
    required super.token,
    required super.role,
    required super.id,
    required super.userType,
    required super.name,
    required super.schoolId,
    required super.message,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] ?? '',
      role: json['role'] ?? '',
      id: json['id'] ?? 0,
      userType: json['userType'],
      name: json['name'],
      schoolId: json['schoolId'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'role': role,
      'userId': id,
      'userType': userType,
      'name': name,
      'schoolId': schoolId,
      'message': message,
    };
  }
}
