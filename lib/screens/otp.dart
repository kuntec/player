import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  String? phoneNumber;
  String? sentOTP;

  OTPScreen({this.sentOTP, this.phoneNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
