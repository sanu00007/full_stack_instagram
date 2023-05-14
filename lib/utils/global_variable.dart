import "package:flutter/material.dart";
import "package:instagram/screen/add_post.dart";
import "package:instagram/screen/feed_screen.dart";
import "package:instagram/screen/home_screen.dart";

const webScreenSize = 600;
const HomeScreenitem = [
  FeedScreen(),
  Text("search"),
  AddPostScreen(),
  Text("notification"),
  Text("profile")
];
