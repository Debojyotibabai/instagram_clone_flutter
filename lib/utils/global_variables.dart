import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/home.dart';
import 'package:instagram_clone/screens/add_post.dart';

const webScreenSize = 600;
const screenOptions = <Widget>[
  AddPost(), //TODO: change later
  Text("Search"),
  AddPost(),
  Text("Favorite"),
  Text("Profile"),
];
