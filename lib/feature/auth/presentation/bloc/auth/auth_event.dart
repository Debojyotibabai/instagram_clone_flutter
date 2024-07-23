part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignup extends AuthEvent {
  AuthSignup({
    required this.avatar,
    required this.email,
    required this.password,
    required this.userName,
    required this.bio,
  });

  final File? avatar;
  final String email;
  final String password;
  final String userName;
  final String bio;
}

final class AuthLogin extends AuthEvent {
  AuthLogin({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
