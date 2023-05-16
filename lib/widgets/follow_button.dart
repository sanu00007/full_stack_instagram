import "package:flutter/material.dart";
import "package:instagram/utils/colors.dart";

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color borderColor;
  final Color backgroundColor;
  final String text;
  final Color textColor;
  const FollowButton(
      {super.key,
      required this.backgroundColor,
      this.function,
      required this.borderColor,
      required this.text,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            width: 280,
            height: 27),
      ),
    );
  }
}
