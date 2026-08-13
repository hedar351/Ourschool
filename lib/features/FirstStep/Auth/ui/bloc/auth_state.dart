part of 'auth_bloc.dart';

final class AuthErorr extends AuthState {
  final String message;

  const AuthErorr({required this.message});
  @override
  List<Object> get props => [message];
}

final class AuthInitial extends AuthState {}

final class AuthLoaded extends AuthState {
  final AuthEntities user;

  const AuthLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

final class AuthLoading extends AuthState {}

final class AuthLogout extends AuthState {}

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}
