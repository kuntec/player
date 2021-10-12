import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const kAppColor = Color(0xffef225b);

//const kBaseColor = Color(0xff3476db);
const kBaseColor = Color(0xff1A4D91);

const kGreyBorder = Color(0xff8e8a8a);

const kHintColor = Color(0xff535151);

const kBackgroundPageColor = Color(0xfff4f7f2);

const kMargin = 10.0;

const k20Margin = 20.0;

const kProfileSize = 180.0;

const kPhotoSize = 110.0;

const kInternet = "No Internet Connection, Please connect to Internet";

const kTitleLargeWhite = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 24.0,
  fontFamily: 'Roboto',
);

const kTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
  fontFamily: "Myriad Pro",
  fontStyle: FontStyle.normal,
);

const kHeadingText = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 16.0,
  fontFamily: "Myriad Pro",
);

const kLabelText = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontSize: 16.0,
  fontFamily: "Myriad Pro",
);

const kValueText = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.normal,
  fontSize: 16.0,
  fontFamily: "Myriad Pro",
);

const kTextNormalWhite = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontSize: 18.0,
);

const kTitleNameTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 22.0,
  fontFamily: 'Myriad Pro',
);

const kNormalTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w600,
  fontSize: 18.0,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: kHintColor),
  filled: true,
  fillColor: Colors.white,
// floatingLabelBehavior: FloatingLabelBehavior.always,
//  labelText: 'Value',
  labelStyle: TextStyle(color: kBaseColor),
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(40.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kGreyBorder, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(40.0)),
    gapPadding: 10,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kGreyBorder, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(40.0)),
    gapPadding: 10,
  ),
);

final kContainerChipBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  border: Border.all(
    color: Colors.black,
    width: 1.0,
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black,
      offset: Offset(0, 2),
      blurRadius: 6.0,
    ),
  ],
);
final kContainerBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(15.0),
  border: Border.all(
    color: Colors.grey,
    width: 1.0,
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(0, 2),
      blurRadius: 6.0,
    ),
  ],
);

final kContainerBox = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(15.0),
  border: Border.all(
    width: 2.0,
    color: CupertinoColors.systemGrey2,
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(0, 2),
      blurRadius: 6.0,
    )
  ],
);
void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    //gravity: ToastGravity.CENTER,
    backgroundColor: kBaseColor,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_LONG,
  );
}
