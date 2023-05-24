import 'package:flutter/material.dart';
import 'package:kura/constants.dart';

class RoundedRectangularButton extends StatelessWidget {
  const RoundedRectangularButton({required this.title});
  final String title;
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
          onPressed: () {},
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
