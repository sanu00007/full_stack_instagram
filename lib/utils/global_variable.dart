import "package:flutter/material.dart";
import "package:instagram/screen/add_post.dart";
import "package:instagram/screen/feed_screen.dart";
import "package:instagram/screen/home_screen.dart";

import "../screen/profile_screen.dart";
import "../screen/search_screen.dart";

const webScreenSize = 600;
const HomeScreenitem = [
  FeedScreen(),
  SearchSCreen(),
  AddPostScreen(),
  Text("notification"),
  ProfileScreen(),
];
