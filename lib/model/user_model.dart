import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.uid,
    required this.avatar,
    required this.userName,
    required this.email,
    this.password,
    required this.bio,
    required this.followers,
    required this.following,
    this.createdAt,
  });

  String uid;
  String avatar;
  String userName;
  String email;
  String? password;
  String bio;
  List<String> followers;
  List<String> following;
  Timestamp? createdAt;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'avatar': avatar,
      'userName': userName,
      'email': email,
      'password': password,
      'bio': bio,
      'followers': followers,
      'following': following,
      'createdAt': createdAt,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    List<String> followersList = List<String>.from(snap['followers']);
    List<String> followingList = List<String>.from(snap['following']);

    return UserModel(
      uid: snap['uid'],
      avatar: snap['avatar'],
      userName: snap['userName'],
      email: snap['email'],
      bio: snap['bio'],
      followers: followersList,
      following: followingList,
      createdAt: snap['createdAt'],
    );
  }
}
