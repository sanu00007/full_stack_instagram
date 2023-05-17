import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram/screen/profile_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'dart:math';

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
  "assets/image30.jpeg",
  "assets/image31.jpeg",
  "assets/image32.jpeg",
  "assets/image33.jpeg",
  "assets/image37.jpeg",
  "assets/image40.jpeg",
  "assets/image34.jpeg",
  "assets/image38.jpeg",
  "assets/image39.jpeg",
  "assets/image24.jpeg",
];

String getRandomImagePath() {
  var random = Random();
  var randomIndex = random.nextInt(imagePaths.length);
  return imagePaths[randomIndex];
}

class SearchSCreen extends StatefulWidget {
  const SearchSCreen({super.key});

  @override
  State<SearchSCreen> createState() => _SearchSCreenState();
}

class _SearchSCreenState extends State<SearchSCreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(labelText: 'search for a user'),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
            ;
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            uid: (snapshot.data! as dynamic).docs[index]['uid'],
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['photourl']),
                        ),
                        title: Text(
                          (snapshot.data! as dynamic).docs[index]['username'],
                        ),
                      ),
                    );
                  }),
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('users').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const CircularProgressIndicator(),
                  );
                }
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: imagePaths.length,
                  itemBuilder: (BuildContext context, int index) => Image.asset(
                    getRandomImagePath(),
                  ),
                  staggeredTileBuilder: (index) => StaggeredTile.count(
                      (index % 7) == 0 ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                );
              },
            ),
    );
  }
}
