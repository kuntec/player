import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/screens/main_navigation.dart';
import 'package:player/screens/venue_screen.dart';

class BookingConfirmation extends StatefulWidget {
  dynamic status;
  BookingConfirmation({required this.status});

  @override
  _BookingConfirmationState createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Booking Confirmation"),
        // ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.status == true ? onSuccess() : onFail(),
              widget.status == true ? homeButton() : tryButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget onSuccess() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: kBaseColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          )
        ],
      ),
      margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Text(
            "Booking Confirm",
            style: TextStyle(fontSize: 24.0, color: kBaseColor),
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: Text(
                "Soon you will receive a call or text message from Team Player",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(height: 40),
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 35,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 45,
            ),
          ),
          SizedBox(height: 40),
          Text(
            "Thanks For Booking",
            style: TextStyle(fontSize: 14.0, color: Colors.black54),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget homeButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MainNavigation(
                      selectedIndex: 0,
                    )),
            (route) => false);
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: kBaseColor,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            )
          ],
        ),
        child: Icon(
          Icons.home_filled,
          color: Colors.white,
          size: 45,
        ),
      ),
    );
  }

  Widget tryButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, true);
      },
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(60),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            )
          ],
        ),
        child: Center(
          child: Text(
            "Try Again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget onFail() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.red),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          )
        ],
      ),
      margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Text(
            "Error!",
            style: TextStyle(fontSize: 24.0, color: Colors.red),
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: Text(
                "Oops, something went wrong.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(height: 40),
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: 35,
            child: Icon(
              Icons.clear,
              color: Colors.white,
              size: 45,
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
