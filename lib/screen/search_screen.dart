import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';

class SearchSCreen extends StatefulWidget {
  const SearchSCreen({super.key});

  @override
  State<SearchSCreen> createState() => _SearchSCreenState();
}

class _SearchSCreenState extends State<SearchSCreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
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
          decoration: InputDecoration(labelText: 'search for user'),
          onFieldSubmitted: (String _) {
            print(_);
          },
        ),
      ),
    );
  }
}
