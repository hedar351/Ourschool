import 'package:equatable/equatable.dart';

class AuthEntities extends Equatable {
  final String? token;
  final String? role;
  final int? id;
  final String? userType;
  final String? name;
  final int? schoolId;
  final String? message;
  const AuthEntities({
    required this.token,
    required this.role,
    required this.id,
    required this.userType,
    required this.name,
    required this.schoolId,
    required this.message,
  });
  @override
  List<Object?> get props => [
    id,
    token,
    role,
    userType,
    name,
    schoolId,
    message,
  ];
}
