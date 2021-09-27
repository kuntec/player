import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/screens/home.dart';
import 'package:player/screens/otp.dart';
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
                'assets/images/player_logo.png',
              ),
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: kMargin,
            ),
            Text(
              "Log in",
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
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Mobile Number', labelText: 'Phone'),
                    cursorColor: kBaseColor,
                  ),
                  SizedBox(height: 30.0),
                  RoundedButton(
                    title: "SEND",
                    color: kBaseColor,
                    txtColor: Colors.white,
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      setState(() {
                        showLoading = true;
                      });
                      await _auth.verifyPhoneNumber(
                        phoneNumber: phoneController.text,
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
                'assets/images/player_logo.png',
              ),
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: kMargin,
            ),
            Text(
              "Enter OTP",
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
                  SizedBox(height: 30.0),
                  RoundedButton(
                    title: "Verify",
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

  sendOTP(String number) async {
    if (Utility.checkValidation(number)) {
      Utility.showToast("Please enter number");
      print("Please enter number");
      return;
    }

    // Fluttertoast.showToast(
    //     msg: "This is Center Short Toast",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);

    String sentOTP = await Utility.generateOTP();
    print("Sent OTP: " + sentOTP);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => OTPScreen(
                  phoneNumber: number,
                  sentOTP: sentOTP,
                )));
  }

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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
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

  loginPhone(String number) async {
    APICall call = new APICall();
    try {
      // LoginData loginData = await call.loginPhone(number);
      // print("Status " + loginData.data.registration_status);
      // print("Token " + loginData.token);
      // if (loginData.status) {
      //   await addSF(loginData.token, loginData.id);
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (_) => PublicProfileScreen()));
      // }
    } catch (e) {
      print("Member exp " + e.toString());
    }
  }

  addSF(String token, String loginId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('loginId', loginId);
    prefs.setBool('isLogin', true);
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('isLogin');
    if (isLogin!) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }
}
