import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
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

class PostCard extends StatelessWidget {
  final snap;

  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

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
                          snap['username'].toString(),
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
                                    onTap: () {},
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
            // child: Image.network(snap['photourl'].toString()),
            child: Image.asset(
              getRandomImagePath(),
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
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
                    " ",
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
                          text: snap['username'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  ${snap['description']}',
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
                      "View all 11.3k comments",
                      style:
                          const TextStyle(fontSize: 15, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    "17/05/2023",
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
