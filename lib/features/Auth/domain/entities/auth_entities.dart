import 'package:equatable/equatable.dart';

class AuthEntities extends Equatable {
  final String username;
  final String token;
  final String role;
  final int? id;

  const AuthEntities({
    required this.username,
    required this.token,
    required this.role,
    required this.id,
  });
  @override
  List<Object?> get props => [
    // id,
    token, username, role,
  ];
}
