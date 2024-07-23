import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/core/use_case/use_case.dart';
import 'package:instagram_clone/feature/auth/domain/repository/auth_repository.dart';

class UserSignup
    implements
        UseCase<Map<String, String>, Map<String, String>, UserSignupParams> {
  UserSignup({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Map<String, String>, Map<String, String>>> call(
    UserSignupParams params,
  ) async {
    final response = await authRepository.signup(
      avatar: params.avatar,
      email: params.email,
      password: params.password,
      userName: params.userName,
      bio: params.bio,
    );

    return response;
  }
}

final class UserSignupParams {
  final File? avatar;
  final String email;
  final String password;
  final String userName;
  final String bio;

  UserSignupParams({
    this.avatar,
    required this.email,
    required this.password,
    required this.userName,
    required this.bio,
  });
}
