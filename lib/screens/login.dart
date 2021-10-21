import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/player_data.dart';
import 'package:player/screens/add_details.dart';
import 'package:player/screens/home.dart';
import 'package:player/screens/main_navigation.dart';
import 'package:player/screens/otp.dart';
import 'package:player/screens/sport_select.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String phoneNumber;
  String btnText = "Send OTP";
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;
  late bool showLoading = false;

  getMobileFormWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.0,
            ),
            Image(
              image: AssetImage(
                'assets/images/login.png',
              ),
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: kMargin,
            ),
            Text(
              "OTP Verification",
              style: const TextStyle(
                color: Colors.black,
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
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Center(
                child: Text(
                  "We will send you an One Time Password on this mobile number",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Column(
                children: [
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Mobile Number',
                        labelText: 'Phone',
                        prefixText: "+91 - "),
                    cursorColor: kBaseColor,
                  ),
                  SizedBox(height: 30.0),
                  RoundedButton(
                    title: "GET OTP",
                    color: kBaseColor,
                    txtColor: Colors.white,
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
//                      checkPlayer(phoneNumber);

                      phoneNumber = "+91" + phoneController.text;

                      print(phoneNumber);
                      setState(() {
                        showLoading = true;
                      });
                      await _auth.verifyPhoneNumber(
                        phoneNumber: phoneNumber,
                        verificationCompleted: (phoneAuthCredential) async {
                          setState(() {
                            showLoading = false;
                          });
//                          signInWithPhoneAuthCredential(phoneAuthCredential);
                        },
                        verificationFailed: (verificationFailed) async {
                          setState(() {
                            showLoading = false;
                          });
                          // _scaffoldKey.currentState!.showSnackBar(
                          //     SnackBar(content: Text("Verification Faile")));
                        },
                        codeSent: (verificationId, resendingToken) async {
                          setState(() {
                            showLoading = false;
                            currentState =
                                MobileVerificationState.SHOW_OTP_FORM_STATE;
                            this.verificationId = verificationId;
                          });
                        },
                        codeAutoRetrievalTimeout: (verificationId) async {
                          setState(() {
                            showLoading = false;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getOtpFormWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.0,
            ),
            Image(
              image: AssetImage(
                'assets/images/otp.png',
              ),
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: k20Margin,
            ),
            Text(
              "OTP Verification",
              style: const TextStyle(
                color: Colors.black,
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
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Center(
                child: Text(
                  "Enter the OTP sent to ${phoneNumber}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Column(
                children: [
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
//                      phoneNumber = value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'OTP', labelText: 'OTP'),
                    cursorColor: kBaseColor,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the OTP? ",
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            showLoading = true;
                          });
                          await _auth.verifyPhoneNumber(
                            phoneNumber: phoneNumber,
                            verificationCompleted: (phoneAuthCredential) async {
                              setState(() {
                                showLoading = false;
                              });
//                          signInWithPhoneAuthCredential(phoneAuthCredential);
                            },
                            verificationFailed: (verificationFailed) async {
                              setState(() {
                                showLoading = false;
                              });
                              // _scaffoldKey.currentState!.showSnackBar(
                              //     SnackBar(content: Text("Verification Faile")));
                            },
                            codeSent: (verificationId, resendingToken) async {
                              setState(() {
                                showLoading = false;
                                currentState =
                                    MobileVerificationState.SHOW_OTP_FORM_STATE;
                                this.verificationId = verificationId;
                              });
                            },
                            codeAutoRetrievalTimeout: (verificationId) async {
                              setState(() {
                                showLoading = false;
                              });
                            },
                          );
                        },
                        child: Text(
                          "RESEND OTP",
                          style: TextStyle(color: kBaseColor, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  RoundedButton(
                    title: "VERIFY & PROCEED",
                    color: kBaseColor,
                    txtColor: Colors.white,
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: otpController.text);
                      signInWithPhoneAuthCredential(phoneAuthCredential);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Init State");
//    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//      appBar: AppBar(
//        title: Text('Login with OTP'),
//      ),
        backgroundColor: Colors.white,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
        ),
      ),
    );
  }

  // sendOTP(String number) async {
  //   if (Utility.checkValidation(number)) {
  //     Utility.showToast("Please enter number");
  //     print("Please enter number");
  //     return;
  //   }
  //
  //   // Fluttertoast.showToast(
  //   //     msg: "This is Center Short Toast",
  //   //     toastLength: Toast.LENGTH_SHORT,
  //   //     gravity: ToastGravity.CENTER,
  //   //     timeInSecForIosWeb: 1,
  //   //     backgroundColor: Colors.red,
  //   //     textColor: Colors.white,
  //   //     fontSize: 16.0);
  //
  //   String sentOTP = await Utility.generateOTP();
  //   print("Sent OTP: " + sentOTP);
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (_) => OTPScreen(
  //                 phoneNumber: number,
  //                 sentOTP: sentOTP,
  //               )));
  // }

  signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        checkPlayer(phoneNumber);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => AddDetails(phoneNumber: phoneNumber)));
      }
    } on FirebaseException catch (e) {
      setState(() {
        showLoading = false;
      });
      // _scaffoldKey.currentState!.showSnackBar(SnackBar(
      //   content: Text("Firebase Exception"),
      // ));
    }
  }

  checkPlayer(String phoneNumber) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      print("Player " + phoneNumber);
//      showToast("Player " + phoneNumber);
      PlayerData playerData = await apiCall.checkPlayer(phoneNumber);
      if (playerData.status!) {
        print("Player Found");
//        showToast("Player Found");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (playerData.player != null) {
          int? playerId = playerData.player!.id;
          String? playerName = playerData.player!.name;
          String? locationId = playerData.player!.locationId;
          String? playerImage = playerData.player!.image;

          prefs.setInt("playerId", playerId!);
          prefs.setString("playerName", playerName!);
          // prefs.setString("playerImage", playerImage!);
          // prefs.setString("locationId", locationId!);
          prefs.setBool('isLogin', true);
        }
        bool? sportSelect = prefs.getBool("sportSelect");

        if (sportSelect != null) {
          if (sportSelect) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MainNavigation()));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SportSelect(player: playerData.player)));
          }
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SportSelect(player: playerData.player)));
        }
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddDetails(phoneNumber: phoneNumber)));
//        showToast(playerData.message!);
//        print(playerData.message!);
      }
    } else {
      showToast(kInternet);
    }
  }

//   checkLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
// //    bool? isLogin = prefs.getBool('isLogin');
//     int? playerId = prefs.getInt("playerId");
//     print(prefs.getInt("playerId"));
//     // print(prefs.getBool('isLogin'));
//     if (playerId != null) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => MainNavigation()));
//     }
//   }
}
