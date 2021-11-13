import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/screens/add_details.dart';
import 'package:player/screens/home.dart';

class OTPScreen extends StatefulWidget {
  String phoneNumber;
  String sentOTP;

  OTPScreen({required this.sentOTP, required this.phoneNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String enteredOTP = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Screen"),
      ),
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
              SizedBox(
                height: kMargin,
              ),
              Text(
                "ENTER OTP to VERIFY",
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
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        enteredOTP = value;
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'ENTER OTP', labelText: 'OTP'),
                      cursorColor: kBaseColor,
                    ),
                    SizedBox(height: 30.0),
                    RoundedButton(
                      title: "Verify",
                      color: kBaseColor,
                      txtColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        // print("clicked" + phoneNumber);
                        // sendOTP(phoneNumber);
                        //checkOTP(enteredOTP);
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

//   checkOTP(String otp) async {
//     if (otp == widget.sentOTP) {
// //      Utility.showToast("OTP MATCHED");
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (_) => AddDetails(
//                     phoneNumber: widget.phoneNumber,
//                   )));
//     } else {
//       Utility.showToast("NO OTP MATCHED");
//     }
//   }
}
