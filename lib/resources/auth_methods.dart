// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/core/model/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Map<String, String>> signup({
    required File? avatar,
    required String userName,
    required String email,
    required String password,
    required String bio,
  }) async {
    String? avatarDownloadUrl = "";

    try {
      if (avatar != null) {
        print(avatar);

        Reference ref =
            _storage.ref().child('avatar/${avatar.uri.pathSegments.last}');

        UploadTask uploadTask = ref.putFile(avatar);

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        avatarDownloadUrl = downloadUrl;
      }

      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        uid: credential.user!.uid,
        avatar: avatarDownloadUrl,
        userName: userName,
        email: email,
        bio: bio,
        password: password,
        followers: [],
        following: [],
        createdAt: null,
      );

      if (credential.user != null) {
        await _firestore.collection('users').doc(credential.user!.uid).set({
          ...user.toMap(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return {"status": "success", "message": "Account created successfully"};
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'email-already-in-use') {
        return {
          "status": "error",
          "message": "The account already exists for that email"
        };
      }

      return {"status": "error", "message": e.toString()};
    } catch (e) {
      print(e);
      return {"status": "error", "message": e.toString()};
    }
  }

  Future<Map<String, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return {"status": "success", "message": "Logged in successfully"};
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == "invalid-credential") {
        return {"status": "error", "message": "Invalid credentials"};
      }

      return {"status": "error", "message": e.toString()};
    } catch (e) {
      print(e);
      return {"status": "error", "message": e.toString()};
    }
  }
}
