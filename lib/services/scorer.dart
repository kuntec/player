import 'package:flutter/material.dart';

class Scorer extends StatefulWidget {
  const Scorer({Key? key}) : super(key: key);

  @override
  _ScorerState createState() => _ScorerState();
}

class _ScorerState extends State<Scorer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Scorer"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
