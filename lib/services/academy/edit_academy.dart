import 'package:flutter/material.dart';

class EditAcademy extends StatefulWidget {
  const EditAcademy({Key? key}) : super(key: key);

  @override
  _EditAcademyState createState() => _EditAcademyState();
}

class _EditAcademyState extends State<EditAcademy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Academy"),
      ),
    );
  }
}
