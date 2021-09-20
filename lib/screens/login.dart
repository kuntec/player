import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/screens/home.dart';
import 'package:player/screens/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNumber = "";
  String btnText = "Send OTP";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//      appBar: AppBar(
//        title: Text('Login with OTP'),
//      ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                // Stack(
                //   children: [
                //     Positioned(
                //       child: Image(
                //         image: AssetImage(
                //           'assets/images/player_logo.png',
                //         ),
                //         width: MediaQuery.of(context).size.width,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //     Positioned(
                //       top: 80.0,
                //       left: 100.0,
                //       child: Center(
                //         child: Image(
                //           image: AssetImage(
                //             'assets/images/player_logo.png',
                //           ),
                //           width: 200.0,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
//            Center(
//              child: Image(
//                image: AssetImage(
//                  'assets/images/nk_dark.png',
//                ),
//                height: 80.0,
//                fit: BoxFit.cover,
//              ),
//            ),
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
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
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
                        title: btnText,
                        color: kBaseColor,
                        txtColor: Colors.white,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          print("clicked" + phoneNumber);
                          sendOTP(phoneNumber);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
