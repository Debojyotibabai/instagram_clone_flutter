// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/core/model/post_model.dart';
import 'package:uuid/uuid.dart';

abstract interface class AddPostDataSource {
  Future<Map<String, String>> addPost({
    required String caption,
    required File image,
    required String uid,
    required String userName,
    required String avatar,
  });
}

class AddPostDataSourceImpl implements AddPostDataSource {
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;

  AddPostDataSourceImpl(
      {required FirebaseStorage storage, required FirebaseFirestore firestore})
      : _storage = storage,
        _firestore = firestore;

  @override
  Future<Map<String, String>> addPost({
    required String caption,
    required File image,
    required String uid,
    required String userName,
    required String avatar,
  }) async {
    String? postImageDownloadUrl = "";
    try {
      Reference ref =
          _storage.ref().child('post/$uid/${image.uri.pathSegments.last}');

      UploadTask uploadTask = ref.putFile(image);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      postImageDownloadUrl = downloadUrl;

      String postId = const Uuid().v1();

      PostModel post = PostModel(
        description: caption,
        uid: uid,
        username: userName,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postImageDownloadUrl,
        profImage: avatar,
      );

      await _firestore.collection('posts').doc(postId).set(post.toMap());

      return {"status": "success", "message": "Posted successfully"};
    } catch (err) {
      print(err);
      throw {"status": "error", "message": err.toString()};
    }
  }
}
