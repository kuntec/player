import 'package:flutter/material.dart';

class AcademyRegister extends StatefulWidget {
  const AcademyRegister({Key? key}) : super(key: key);

  @override
  _AcademyRegisterState createState() => _AcademyRegisterState();
}

class _AcademyRegisterState extends State<AcademyRegister> {
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
        title: Text("Academy Register"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
