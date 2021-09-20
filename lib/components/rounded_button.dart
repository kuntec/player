import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.title,
      required this.color,
      required this.onPressed,
      required this.minWidth,
      required this.txtColor});

  final Color color;
  final String title;
  final VoidCallback onPressed;
  final double minWidth;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: minWidth,
          height: 50.0,
          child: Text(
            title,
            style: TextStyle(
              color: txtColor,
              fontSize: 20.0,
              fontFamily: "Myriad Pro",
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}
