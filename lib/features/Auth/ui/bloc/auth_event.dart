part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  final bool rememberMe;
  const LoginEvent({
    required this.username,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object> get props => [username, password, rememberMe];
}

class LogoutEvent extends AuthEvent {}
