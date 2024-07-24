import 'package:flutter/material.dart';
import 'package:instagram_clone/feature/app/presentation/pages/home_screen.dart';
import 'package:instagram_clone/feature/app/presentation/pages/add_post_screen.dart';

const webScreenSize = 600;
const screenOptions = <Widget>[
  HomeScreen(),
  Text("Search"),
  AddPostScreen(),
  Text("Favorite"),
  Text("Profile"),
];
