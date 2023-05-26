import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tik_shok/view/screens/add_video_screen.dart';
import 'package:tik_shok/view/screens/display_video_screen.dart';
import 'package:tik_shok/view/screens/profile_screen.dart';
import 'package:tik_shok/view/screens/search_screen.dart';

//colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
final pageIndex = [
  DisplayVideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  Text(" comming Soon in New Update"),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
