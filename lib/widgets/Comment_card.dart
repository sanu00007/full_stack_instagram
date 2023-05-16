import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/post_card.dart';
import 'dart:math';
import 'package:intl/intl.dart';

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

String generateRandomFormattedDate() {
  final startDate = DateTime(2023, 12, 29);
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

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: _getBackgroundImage(),
            radius: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: primaryColor),
                    children: [
                      TextSpan(
                        text: widget.snap['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            '      ${widget.snap['text']}                                    ',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                  ),
                  child: Text(
                    generateRandomFormattedDate(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   child: Icon(
          //     Icons.favorite,
          //     size: 16,
          //   ),
          // ),
        ],
      ),
    );
  }
}
