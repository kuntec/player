import 'package:flutter/material.dart';

class Helper extends StatefulWidget {
  const Helper({Key? key}) : super(key: key);

  @override
  _HelperState createState() => _HelperState();
}

class _HelperState extends State<Helper> {
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
        title: Text("Helper"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
