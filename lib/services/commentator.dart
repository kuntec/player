import 'package:flutter/material.dart';

class Commentator extends StatefulWidget {
  const Commentator({Key? key}) : super(key: key);

  @override
  _CommentatorState createState() => _CommentatorState();
}

class _CommentatorState extends State<Commentator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text("Commentator"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
