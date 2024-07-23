import 'dart:io';

import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Map<String, String>, Map<String, String>>> signup({
    required File? avatar,
    required String email,
    required String password,
    required String userName,
    required String bio,
  });

  Future<Either<Map<String, String>, Map<String, String>>> login({
    required String email,
    required String password,
  });
}
