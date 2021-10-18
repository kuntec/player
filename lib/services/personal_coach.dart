import 'package:flutter/material.dart';

class PersonalCoach extends StatefulWidget {
  const PersonalCoach({Key? key}) : super(key: key);

  @override
  _PersonalCoachState createState() => _PersonalCoachState();
}

class _PersonalCoachState extends State<PersonalCoach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Personal Coach"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
