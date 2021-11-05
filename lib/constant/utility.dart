import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:player/constant/constants.dart';

class Utility {
  static bool isKeyboardShowing() {
    if (WidgetsBinding.instance != null) {
      return WidgetsBinding.instance!.window.viewInsets.bottom > 0;
    } else {
      return false;
    }
  }

  static closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static Future<bool> checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } else if (result == ConnectivityResult.mobile) {
      return true;
    } else if (result == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static String generateOTP() {
    return "7588";
    // int min = 10000; //min and max values act as your 5 digit range
    // int max = 99999;
    // var randomizer = new Random();
    // var rNum = min + randomizer.nextInt(max - min);
    // return rNum.toString();
  }

  static bool checkValidation(String value) {
    if (value.trim() == "" || value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  static String getCurrentDate() {
    final initialDate = DateTime.now();
    return "${initialDate.day}-${initialDate.month}-${initialDate.year}";
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
//    gravity: ToastGravity.CENTER,
      backgroundColor: kBaseColor,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static launchCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
