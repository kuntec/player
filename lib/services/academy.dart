import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/services/academy_register.dart';

class Academy extends StatefulWidget {
  const Academy({Key? key}) : super(key: key);

  @override
  _AcademyState createState() => _AcademyState();
}

class _AcademyState extends State<Academy> {
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
        title: Text("Academy"),
        actions: [
          Container(
            child: Row(
              children: [
                TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AcademyRegister()));
                    },
                    icon: Icon(
                      Icons.add,
                      color: kBaseColor,
                    ),
                    label: Text(
                      "Register",
                      style: TextStyle(color: kBaseColor),
                    ))
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(),
    );
  }
}
