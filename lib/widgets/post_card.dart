import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/responsive/firestore_method.dart';
import 'package:instagram/screen/comment_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../model/user.dart' as model;
import '../providers/user_provider.dart';
import 'like_animation.dart';

String generateRandomFormattedDate() {
  final startDate = DateTime(2023, 12, 21);
  final endDate = DateTime(2023, 12, 31);
  final randomDate = generateRandomDate(startDate, endDate);
  final formattedDate = DateFormat('dd/MM/yyyy').format(randomDate);
  return formattedDate;
}

DateTime generateRandomDate(DateTime startDate, DateTime endDate) {
  final random = Random();
  final minSeconds = startDate.millisecondsSinceEpoch;
  final maxSeconds = endDate.millisecondsSinceEpoch;
  final randomSeconds =
      minSeconds + random.nextInt(maxSeconds - minSeconds + 1);
  return DateTime.fromMillisecondsSinceEpoch(randomSeconds);
}

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
  "assets/image40.jpeg",
  "assets/image29.jpeg",
  "assets/image39.jpeg",
  "assets/image38.jpeg", "assets/image35.jpeg", "assets/image34.jpeg",
  // Add more image paths as needed
];

String getRandomImagePath() {
  var random = Random();
  var randomIndex = random.nextInt(imagePaths.length);
  return imagePaths[randomIndex];
}

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentlen = 0;
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['uid'])
          .collection('comment')
          .get();
      commentlen = snap.docs.length;
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: _getBackgroundImage(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shrinkWrap: true,
                            children: ['Delete']
                                .map(
                                  (e) => InkWell(
                                    onTap: () async {
                                      FireStoreMethods()
                                          .deletePost(widget.snap['uid']);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.asset(
              getRandomImagePath(),
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              LikeAnimation(
                smallLike: true,
                isAnimating: true,
                onEnd: () {},
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Commentscreen(snap: widget.snap))),
                icon: Icon(
                  Icons.comment_outlined,
                  color: primaryColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.bookmark_border)),
              ))
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${widget.snap['likes']} likes',
                    // '${snap['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['username'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  ${widget.snap['description']}',
                          // style: TextStyle(
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "View all ${commentlen} comments",
                      style:
                          const TextStyle(fontSize: 15, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    generateRandomFormattedDate(),
                    style: const TextStyle(fontSize: 15, color: secondaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
