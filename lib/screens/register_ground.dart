import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';

class RegisterGround extends StatefulWidget {
  const RegisterGround({Key? key}) : super(key: key);

  @override
  _RegisterGroundState createState() => _RegisterGroundState();
}

class _RegisterGroundState extends State<RegisterGround> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Your Ground"),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBaseColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  //otherInfo = value;
                },
                decoration: InputDecoration(
                    labelText: "Ground Name",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              TextField(
                onChanged: (value) {
                  //otherInfo = value;
                },
                decoration: InputDecoration(
                    labelText: "Address",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              TextField(
                onChanged: (value) {
                  //otherInfo = value;
                },
                decoration: InputDecoration(
                    labelText: "City",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              TextField(
                onChanged: (value) {
                  //otherInfo = value;
                },
                decoration: InputDecoration(
                    labelText: "Select Ground Type",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              TextField(
                onChanged: (value) {
                  //otherInfo = value;
                },
                decoration: InputDecoration(
                    labelText: "Contact Person Name",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              TextField(
                onChanged: (value) {
                  //otherInfo = value;
                },
                decoration: InputDecoration(
                    labelText: "Primary Contact Number",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              TextField(
                onChanged: (value) {
                  //otherInfo = value;
                },
                decoration: InputDecoration(
                    labelText: "Secondary Contact Number",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                onChanged: (value) {
                  //otherInfo = value;
                },
                decoration: InputDecoration(
                    labelText: "About Your Ground",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              SizedBox(height: k20Margin),
              RoundedButton(
                  title: "Register Ground",
                  color: kBaseColor,
                  onPressed: () {},
                  minWidth: 250,
                  txtColor: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
