import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:instagram/providers/user_provider.dart";
import "package:instagram/utils/dimension.dart";
import "package:provider/provider.dart";

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        if (Constraints.maxWidth > webScreenSize) {
          return widget.webScreenLayout;
          //web screen
        }
        return widget.mobileScreenLayout;
        //mobilescreen
      },
    );
  }
}
