import 'package:flutter/material.dart';

class LocationSelectScreen extends StatefulWidget {
  const LocationSelectScreen({Key? key}) : super(key: key);

  @override
  _LocationSelectScreenState createState() => _LocationSelectScreenState();
}

class _LocationSelectScreenState extends State<LocationSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: Container(),
    ));
  }
}
