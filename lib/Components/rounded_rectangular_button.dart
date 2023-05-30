import 'package:flutter/material.dart';
import 'package:kura/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Screens/chat_screen.dart';

class RoundedRectangularButton extends StatelessWidget {
  const RoundedRectangularButton(
      {required this.title, this.onPressed, super.key});

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 60,
        width: double.maxFinite,
        color: kPrimaryColor,
        child: TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.white.withOpacity(0.2))),
          onPressed: onPressed,
          child: Center(
              child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
