import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/dimension.dart';
import 'package:instagram/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: width > webScreenSize
                  ? webBackgroundColor
                  : mobileBackgroundColor,
              centerTitle: false,
              title: Image.asset(
                "assets/image3.jpg",
                height: 42,
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.messenger_outline,
                    ))
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(
                        vertical: width > webScreenSize ? 15 : 0,
                        horizontal: width > webScreenSize ? width * 0.3 : 0),
                    child: PostCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  ));
        },
      ),
    );
  }
}
