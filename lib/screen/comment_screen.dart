import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/responsive/firestore_method.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../widgets/Comment_card.dart';
import 'dart:math';

int getRandomInt(int max) {
  var random = Random();
  return random.nextInt(max);
}

AssetImage _getBackgroundImage() {
  switch (getRandomInt(5)) {
    case 0:
      return AssetImage('assets/image11.jpeg');
    case 1:
      return AssetImage('assets/image12.jpeg');
    case 2:
      return AssetImage('assets/image13.jpeg');
    case 3:
      return AssetImage('assets/image14.jpeg');
    case 4:
      return AssetImage('assets/image15.jpeg');
    default:
      return AssetImage('assets/image10.jpeg');
  }
}

List<String> imagePaths = [
  "assets/image6.jpg",
  "assets/image21.jpeg",
  "assets/image22.jpeg",
  "assets/image23.jpeg",
  "assets/image24.jpeg",
  "assets/image25.jpeg",
  "assets/image26.jpeg",
  "assets/image27.jpeg",
  "assets/image28.jpeg",
  "assets/image10.jpeg",
  "assets/image29.jpeg",
  // Add more image paths as needed
];

String getRandomImagePath() {
  var random = Random();
  var randomIndex = random.nextInt(imagePaths.length);
  return imagePaths[randomIndex];
}

class Commentscreen extends StatefulWidget {
  final snap;
  const Commentscreen({super.key, required this.snap});

  @override
  State<Commentscreen> createState() => _CommentscreenState();
}

class _CommentscreenState extends State<Commentscreen> {
  final TextEditingController _commentcontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("comments"),
        centerTitle: false,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['uid'])
              .collection('comment')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => CommentCard(
                snap: (snapshot.data! as dynamic).docs[index].data(),
              ),
            );
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: _getBackgroundImage(),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8),
                  child: TextField(
                    controller: _commentcontroller,
                    decoration: InputDecoration(
                      hintText: 'comment as you',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showSnackbar('comment is posted successfully', context);

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ResponsiveLayout(
                            webScreenLayout: WebScreenLayout(),
                            mobileScreenLayout: MobileScreenlayout(),
                          )));
                  // await FireStoreMethods().postComment(
                  //     widget.snap['uid'],
                  //     _commentcontroller.text,
                  //     widget.snap['name'],
                  //     widget.snap['commentid']);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
