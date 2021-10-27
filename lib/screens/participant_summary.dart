import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/participant_data.dart';
import 'package:player/screens/payment_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParticipantSummary extends StatefulWidget {
  dynamic event;
  dynamic isEvent;
  ParticipantSummary({this.event, this.isEvent});

  @override
  _ParticipantSummaryState createState() => _ParticipantSummaryState();
}

class _ParticipantSummaryState extends State<ParticipantSummary> {
  var name;
  var number;
  var gender;
  var age;
  var type;
  var amount;
  var paymentMode;

  Participant? participant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: widget.isEvent == true ? Text("Event") : Text("Tournament"),
        ),
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
          margin: EdgeInsets.all(kMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Fill your details",
                style: TextStyle(color: Colors.black87, fontSize: 18.0),
              ),
              SizedBox(height: kMargin),
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(
                    labelText: "Enter Your Name",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              SizedBox(height: kMargin),
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  number = value;
                },
                decoration: InputDecoration(
                    labelText: "Contact Number",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              SizedBox(height: kMargin),
              Center(child: Text("Gender")),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Radio(
                      value: "Male",
                      groupValue: gender,
                      onChanged: (value) {
                        gender = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: GestureDetector(
                        onTap: () {
                          gender = "Male";
                          setState(() {});
                        },
                        child: Text("Male")),
                  ),
                  Expanded(
                    flex: 10,
                    child: Radio(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (value) {
                        gender = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: GestureDetector(
                      onTap: () {
                        gender = "Female";
                        setState(() {});
                      },
                      child: Text("Female"),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: kMargin),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  age = value;
                },
                decoration: InputDecoration(
                    labelText: "Age",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              SizedBox(height: kMargin),
              Center(child: Text("Payment Mode")),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Radio(
                      value: "1",
                      groupValue: paymentMode,
                      onChanged: (value) {
                        paymentMode = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: GestureDetector(
                        onTap: () {
                          paymentMode = "1";
                          setState(() {});
                        },
                        child: Text("Online")),
                  ),
                  Expanded(
                    flex: 10,
                    child: Radio(
                      value: "0",
                      groupValue: paymentMode,
                      onChanged: (value) {
                        paymentMode = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: GestureDetector(
                      onTap: () {
                        paymentMode = "0";
                        setState(() {});
                      },
                      child: Text("Offline"),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: k20Margin),
              Container(
                margin: EdgeInsets.only(left: k20Margin, right: k20Margin),
                child: RoundedButton(
                  title: "Proceed To Payment",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var playerId = prefs.get("playerId");
                    if (name == null || Utility.checkValidation(name)) {
                      Utility.showToast("Please enter name");
                      return;
                    }
                    if (number == null || Utility.checkValidation(number)) {
                      Utility.showToast("Please enter number");
                      return;
                    }
                    if (gender == null || Utility.checkValidation(gender)) {
                      Utility.showToast("Please select gender");
                      return;
                    }
                    if (age == null || Utility.checkValidation(age)) {
                      Utility.showToast("Please enter age");
                      return;
                    }

                    if (paymentMode == null ||
                        Utility.checkValidation(paymentMode)) {
                      Utility.showToast("Please select payment mode");
                      return;
                    }

                    widget.isEvent == true ? type = "1" : type = "0";

                    amount = widget.event.entryFees;

                    participant = new Participant();
                    participant!.name = name.toString();
                    participant!.playerId = playerId.toString();
                    participant!.status = "1";
                    participant!.type = type.toString();
                    participant!.number = number.toString();
                    participant!.age = age.toString();
                    participant!.gender = gender.toString();
                    participant!.paymentId = "";
                    participant!.paymentMode = paymentMode.toString();
                    participant!.paymentStatus = "2";
                    participant!.eventId = widget.event.id.toString();
                    participant!.amount = amount.toString();

                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                                  participant: participant,
                                  event: widget.event,
                                )));
                    if (result == true) {
                      print("poping summary");
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
