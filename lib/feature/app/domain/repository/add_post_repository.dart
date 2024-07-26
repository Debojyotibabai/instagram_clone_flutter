import 'dart:io';

import 'package:fpdart/fpdart.dart';

abstract interface class AddPostRepository {
  Future<Either<Map<String, String>, Map<String, String>>> addPost({
    required String caption,
    required File image,
    required String uid,
    required String userName,
    required String avatar,
  });
}
