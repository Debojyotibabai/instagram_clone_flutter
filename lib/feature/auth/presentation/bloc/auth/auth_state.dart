part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final Map<String, String> response;

  AuthSuccess(this.response);
}

final class AuthError extends AuthState {
  final Map<String, String> response;

  AuthError(this.response);
}
