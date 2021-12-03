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

const startColor = Color(0xff000000);
const hostEndColor = Color(0xff197AFF);
const friendEndColor = Color(0xff00D7FF);
const tournamentEndColor = Color(0xff00FF93);
const eventEndColor = Color(0xff9001DB);
const offerEndColor = Color(0xffEB0808);
const kBlack = Color(0xff000000);

const kInternet = "No Internet Connection, Please connect to Internet";

const kServices =
    '{"status":true,"message":"Services Found","services":[{"id":2,"name":"Trophy Sellers","icon":"services\/phiS6WmggXtuf2Vq6hxd4qdlGMUUy4HgkIu33QdB.png","service_order":"1"},{"id":8,"name":"Sports Market","icon":"services\/2b5ZuhHKWNyGfXLwgTTrYOcpamECX2PXt4Fpe5bb.png","service_order":"2"},{"id":7,"name":"T-shirt Sellers","icon":"services\/FnC5bRyDjWst0I8tnSOInGopM8jTXwuvONl7Jwlk.png","service_order":"3"},{"id":4,"name":"Scorers","icon":"services\/PJ4zR7EDsD9pLN5N01UTDTXj2VbMlUVRmDkyoZOF.png","service_order":"4"},{"id":9,"name":"Umpires","icon":"services\/uHnI9rjhd0sgyDTg4AcU7vtHETzaie2fuCuHOX6N.png","service_order":"5"},{"id":11,"name":"Commentator","icon":"services\/XH9TPOt9f8Vi75uk6YBPtUUDgABcrBCu5OS9YNxz.png","service_order":"6"},{"id":6,"name":"Academy","icon":"services\/O5nQzP5dokjZ3DQoUhrCJYsRZMjcI7rBhtfFd358.png","service_order":"7"},{"id":13,"name":"Item Rental","icon":"services\/9dvJ3WraVPbemUIoPF10t6NHnGU8quaavWaFIe2U.png","service_order":"8"},{"id":12,"name":"Helpers","icon":"services\/subcgT2E4xeE4PnT1qGrI3atJ3yWr3EZCI3mWc5q.png","service_order":"9"},{"id":3,"name":"Manufacturers","icon":"services\/tR9JCGom2V9BNCnUh97glByKwpaavwfjsjTs7Jxn.png","service_order":"10"},{"id":1,"name":"Personal Coach","icon":"services\/J7cUfpqV0lh5Mu4Vs1B80doSU9XY4p9XFpQZZmcn.png","service_order":"11"},{"id":10,"name":"Physio & Fitness","icon":"services\/HXbuBWNH017vQe47qgQ70Z4LwecItVgYl7GGnuq3.png","service_order":"12"}]}';

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

final kContainerTabLeftDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10.0),
    bottomLeft: Radius.circular(10.0),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(0, 2),
      blurRadius: 6.0,
    )
  ],
  // border: Border.all(
  //   color: Colors.grey,
  //   width: 1.0,
  // ),
);

final kContainerTabRightDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(0, 2),
      blurRadius: 6.0,
    )
  ],
  // border: Border.all(
  //   color: Colors.grey,
  //   width: 1.0,
  // ),
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

final kBoxDecor = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(5.0),
  border: Border.all(
    color: Colors.grey,
    width: 0.5,
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

final kBoxItem = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(5.0),
  border: Border.all(
    color: Colors.grey,
    width: 0,
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(0, 2),
      blurRadius: 6.0,
    )
  ],
);

final kServiceBoxItem = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(15.0),
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
