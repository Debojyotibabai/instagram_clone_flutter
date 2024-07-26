import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/feature/app/data/data_source/add_post_data_source.dart';
import 'package:instagram_clone/feature/app/domain/repository/add_post_repository.dart';

class AddPostRepositoryImpl implements AddPostRepository {
  final AddPostDataSource _addPostDataSource;

  AddPostRepositoryImpl({required AddPostDataSource addPostDataSource})
      : _addPostDataSource = addPostDataSource;

  @override
  Future<Either<Map<String, String>, Map<String, String>>> addPost({
    required String caption,
    required File image,
    required String uid,
    required String userName,
    required String avatar,
  }) async {
    try {
      final response = await _addPostDataSource.addPost(
        avatar: avatar,
        image: image,
        caption: caption,
        uid: uid,
        userName: userName,
      );

      return Right(response);
    } catch (err) {
      return Left(err as Map<String, String>);
    }
  }
}
