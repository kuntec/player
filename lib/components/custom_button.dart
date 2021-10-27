import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {required this.title,
      required this.color,
      required this.onPressed,
      required this.minWidth,
      required this.height,
      required this.txtColor,
      required this.fontSize});

  final Color color;
  final String title;
  final VoidCallback onPressed;
  final double minWidth;
  final double height;
  final double fontSize;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: minWidth,
          height: height,
          child: Text(
            title,
            style: TextStyle(
              color: txtColor,
              fontSize: fontSize,
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
