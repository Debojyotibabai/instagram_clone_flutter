import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/model/user_model.dart';

abstract interface class CurrentUserDataSource {
  Future<UserModel> getCurrentUserData();
}

class CurrentUserDataSourceImpl implements CurrentUserDataSource {
  final FirebaseAuth _auth;

  CurrentUserDataSourceImpl({required FirebaseAuth auth}) : _auth = auth;

  @override
  Future<UserModel> getCurrentUserData() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      final DocumentSnapshot snapshot =
          await users.doc(_auth.currentUser!.uid).get();

      return UserModel.fromSnap(snapshot);
    } catch (e) {
      throw {"status": "error", "message": e.toString()};
    }
  }
}
