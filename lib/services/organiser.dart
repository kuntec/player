import 'package:flutter/material.dart';

class Organiser extends StatefulWidget {
  const Organiser({Key? key}) : super(key: key);

  @override
  _OrganiserState createState() => _OrganiserState();
}

class _OrganiserState extends State<Organiser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Organiser"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
