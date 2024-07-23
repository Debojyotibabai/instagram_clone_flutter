import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/feature/auth/data/data_source/auth_data_source.dart';
import 'package:instagram_clone/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authDataSource});

  final AuthDataSource authDataSource;
  @override
  Future<Either<Map<String, String>, Map<String, String>>> signup({
    required File? avatar,
    required String email,
    required String password,
    required String userName,
    required String bio,
  }) async {
    try {
      final response = await authDataSource.signup(
        avatar: avatar,
        email: email,
        password: password,
        userName: userName,
        bio: bio,
      );

      return Right(response);
    } catch (err) {
      return Left(err as Map<String, String>);
    }
  }

  @override
  Future<Either<Map<String, String>, Map<String, String>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authDataSource.login(
        email: email,
        password: password,
      );

      return Right(response);
    } catch (err) {
      return Left(err as Map<String, String>);
    }
  }
}
