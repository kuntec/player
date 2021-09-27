import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/sport_select.dart';

class AddDetails extends StatefulWidget {
  String phoneNumber;
  AddDetails({required this.phoneNumber});

  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  late String name;
  late String dob;
  late String gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD DETAILS"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: k20Margin,
              ),
              Text(
                "KINDLY ADD YOUR DETAIL",
                style: const TextStyle(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.8,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        name = value;
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'FULL NAME'),
                      cursorColor: kBaseColor,
                    ),
                    SizedBox(
                      height: k20Margin,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        dob = value;
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'ENTER BIRTHDAY dd/mm/yyy'),
                      cursorColor: kBaseColor,
                    ),
                    SizedBox(
                      height: k20Margin,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        gender = value;
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'GENDER'),
                      cursorColor: kBaseColor,
                    ),
                    SizedBox(
                      height: k20Margin,
                    ),
                    RoundedButton(
                      title: "CONTINUE",
                      color: kBaseColor,
                      txtColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        await addPlayer(name, widget.phoneNumber, dob, gender);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  goToSportSelect() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => SportSelect()));
  }

  addPlayer(String name, String phoneNumber, String dob, String gender) async {
    APICall apiCall = new APICall();

    await apiCall.addPlayer(name, phoneNumber, dob, gender);
  }
}
