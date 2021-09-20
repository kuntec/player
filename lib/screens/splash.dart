import 'package:flutter/material.dart';
import 'package:player/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    goToLogin(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("PLAYER APP"),
        ),
      ),
    );
  }

  goToLogin(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }
}
