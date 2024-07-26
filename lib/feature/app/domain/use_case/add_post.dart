import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/core/use_case/use_case.dart';
import 'package:instagram_clone/feature/app/domain/repository/add_post_repository.dart';

class AddPost
    implements
        UseCase<Map<String, String>, Map<String, String>, AddPostParams> {
  final AddPostRepository _addPostRepository;

  AddPost({required AddPostRepository addPostRepository})
      : _addPostRepository = addPostRepository;

  @override
  Future<Either<Map<String, String>, Map<String, String>>> call(
      AddPostParams params) async {
    return await _addPostRepository.addPost(
      caption: params.caption,
      image: params.image,
      uid: params.uid,
      userName: params.userName,
      avatar: params.avatar,
    );
  }
}

final class AddPostParams {
  final String caption;
  final File image;
  final String uid;
  final String userName;
  final String avatar;

  AddPostParams({
    required this.caption,
    required this.image,
    required this.uid,
    required this.userName,
    required this.avatar,
  });
}
