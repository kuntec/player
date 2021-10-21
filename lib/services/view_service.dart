import 'package:flutter/material.dart';

class ViewService extends StatefulWidget {
  const ViewService({Key? key}) : super(key: key);

  @override
  _ViewServiceState createState() => _ViewServiceState();
}

class _ViewServiceState extends State<ViewService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Service"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
