import 'package:flutter/material.dart';

class Umpire extends StatefulWidget {
  const Umpire({Key? key}) : super(key: key);

  @override
  _UmpireState createState() => _UmpireState();
}

class _UmpireState extends State<Umpire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Umpire"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
