import "dart:typed_data";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:instagram/screen/add_post.dart";
import "package:instagram/screen/feed_screen.dart";

import "../screen/profile_screen.dart";
import "../screen/search_screen.dart";

const webScreenSize = 600;
// const HomeScreenitem = [
//   FeedScreen(),
//   SearchSCreen(),
//   AddPostScreen(),
//   Text("notification"),
//   ProfileScreen(
//     uid: String hell,
//   ),
// ];
List<Widget> HomeScreenitem = [
  const FeedScreen(),
  const SearchSCreen(),
  const AddPostScreen(),
  const Text('notification'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
