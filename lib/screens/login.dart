import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/chatmodels/user_chat.dart';
import 'package:player/chatprovider/home_provider.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/firestore_constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/my_sport.dart';
import 'package:player/model/player_data.dart';
import 'package:player/screens/add_details.dart';
import 'package:player/screens/home.dart';
import 'package:player/screens/main_navigation.dart';
import 'package:player/screens/otp.dart';
import 'package:player/screens/sport_select.dart';
import 'package:player/service/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  final SharedPreferences prefs;
  LoginScreen({required this.prefs});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

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
              height: 50.0,
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
                    decoration: InputDecoration(
                        labelText: "Enter Mobile Number",
                        prefixText: "+91 - ",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                  // TextField(
                  //   controller: phoneController,
                  //   keyboardType: TextInputType.phone,
                  //   onChanged: (value) {
                  //     phoneNumber = value;
                  //   },
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //   ),
                  //   decoration: kTextFieldDecoration.copyWith(
                  //       hintText: 'Enter Mobile Number',
                  //       labelText: 'Phone',
                  //       prefixText: "+91 - "),
                  //   cursorColor: kBaseColor,
                  // ),
                  SizedBox(height: 30.0),
                  showLoading
                      ? CircularProgressIndicator()
                      : RoundedButton(
                          title: "GET OTP",
                          color: kBaseColor,
                          txtColor: Colors.white,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
//                      checkPlayer(phoneNumber);

                            if (Utility.checkValidation(
                                phoneController.text.toString())) {
                              Utility.showToast("Please Enter Number");
                              return;
                            }
                            FocusScope.of(context).requestFocus(FocusNode());

                            phoneNumber = "+91" + phoneController.text;

                            print(phoneNumber);
                            setState(() {
                              showLoading = true;
                            });
                            await _auth.verifyPhoneNumber(
                              phoneNumber: phoneNumber,
                              verificationCompleted:
                                  (phoneAuthCredential) async {
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
                                  currentState = MobileVerificationState
                                      .SHOW_OTP_FORM_STATE;
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
              height: 50.0,
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
                  "Enter the OTP sent to $phoneNumber",
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
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: OTPTextField(
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 30,
                      style: TextStyle(fontSize: 14),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.underline,
                      obscureText: true,
                      onChanged: (pin) {},
                      onCompleted: (pin) {
                        print("Completed: " + pin);
                        otpController.text = pin;
                      },
                    ),
                  ),
                  // TextField(
                  //   controller: otpController,
                  //   keyboardType: TextInputType.number,
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //   ),
                  //   decoration: kTextFieldDecoration.copyWith(
                  //       hintText: 'OTP', labelText: 'OTP'),
                  //   cursorColor: kBaseColor,
                  // ),
                  SizedBox(
                    height: 20.0,
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
                  showLoading
                      ? CircularProgressIndicator()
                      : RoundedButton(
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
  late HomeProvider homeProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Init State");
    homeProvider = context.read<HomeProvider>();
    FirebaseMessaging.instance.getInitialMessage();

    _fcm.getToken().then((value) {
      widget.prefs.setString("device_token", value!);
      print("Device Token ${value}");
    });

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //    final routeFromMessage = message.data["route"];
//      print("Data received from Notification ${routeFromMessage}");
    });

    checkLogin();
  }

  registerNotification(currentUserId) {
    _fcm.requestPermission();
    _fcm.getToken().then((token) {
      if (token != null) {
        homeProvider.updateDataFirestore(FirestoreContants.pathUserCollection,
            currentUserId, {'pushToken': token});
      }
    });
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
          child: currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
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
      // setState(() {
      //   showLoading = false;
      // });

      if (authCredential.user != null) {
        User? firebaseUser = authCredential.user;

        //Utility.showToast("User Found ${firebaseUser!.uid}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("fuid", firebaseUser!.uid);

        bool status = await addFirebaseDocument(firebaseUser);
        String? device_token = prefs.getString("device_token");
        checkPlayer(phoneNumber, firebaseUser.uid, device_token!);

        // setState(() {
        //   showLoading = false;
        // });
      } else {
        setState(() {
          showLoading = false;
        });
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

  checkPlayer(String phoneNumber, String fuid, String device_token) async {
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
          String? mobile = playerData.player!.mobile;
          String? locationId = playerData.player!.locationId;
          String? city = playerData.player!.city;
          String? playerFuid = playerData.player!.fuid;

          prefs.setInt("playerId", playerId!);
          prefs.setString("playerName", playerName!);
          prefs.setString("mobile", mobile!);
          prefs.setString("fuid", playerFuid!);
          prefs.setString("locationId", locationId!);
          prefs.setString("city", city!);
          prefs.setBool('isLogin', true);

          registerNotification(playerData.player!.fuid);
        }
        await getMySports(playerData.player!.id.toString());
        //bool? sportSelect = prefs.getBool("sportSelect");
        // print("Sport select $sportSelect");
        if (sportSelect != null) {
          if (sportSelect!) {
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MainNavigation(
                          selectedIndex: 0,
                        )));
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
                builder: (context) => AddDetails(
                      phoneNumber: phoneNumber,
                      fuid: fuid,
                      deviceToken: device_token,
                    )));
//        showToast(playerData.message!);
//        print(playerData.message!);
      }
      setState(() {
        showLoading = false;
      });
    } else {
      showToast(kInternet);
    }
  }

  checkLogin() async {
    print("Checking Login");
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    bool? isLogin = prefs.getBool('isLogin');
    int? playerId = prefs.getInt("playerId");
    print(prefs.getInt("playerId"));

    if (playerId != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => MainNavigation(
                    selectedIndex: 0,
                  )));
    }
  }

  addFirebaseDocument(User firebaseUser) async {
    if (firebaseUser != null) {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final QuerySnapshot result = await firebaseFirestore
          .collection(FirestoreContants.pathUserCollection)
          .where(FirestoreContants.id, isEqualTo: firebaseUser.uid)
          .get();

      final List<DocumentSnapshot> document = result.docs;
      if (document.length == 0) {
        firebaseFirestore
            .collection(FirestoreContants.pathUserCollection)
            .doc(firebaseUser.uid)
            .set({
          FirestoreContants.nickname: firebaseUser.displayName,
          FirestoreContants.photoUrl: firebaseUser.photoURL,
          FirestoreContants.id: firebaseUser.uid,
          "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
          FirestoreContants.chattingWith: null
        });

        User? currentUser = firebaseUser;
        await prefs.setString(FirestoreContants.id, currentUser.uid);
        await prefs.setString(
            FirestoreContants.nickname, currentUser.displayName ?? "");
        await prefs.setString(
            FirestoreContants.photoUrl, currentUser.photoURL ?? "");
        await prefs.setString(
            FirestoreContants.phoneNumber, currentUser.phoneNumber ?? "");
      } else {
        DocumentSnapshot documentSnapshot = document[0];
        UserChat userChat = UserChat.fromDocument(documentSnapshot);

        await prefs.setString(FirestoreContants.id, userChat.id);
        await prefs.setString(FirestoreContants.nickname, userChat.nickname);
        await prefs.setString(FirestoreContants.photoUrl, userChat.photoUrl);
        await prefs.setString(
            FirestoreContants.phoneNumber, userChat.phoneNumber);
      }
      registerNotification(firebaseUser.uid);
    }
    return true;
  }

  bool? sportSelect = false;

  Future<bool> getMySports(String playerId) async {
    APICall apiCall = new APICall();
    // List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      MySport mySport = await apiCall.getMySports(playerId.toString());

      if (mySport.sports != null) {
        if (mySport.sports!.length == 0) {
          sportSelect = false;
        } else {
          sportSelect = true;
        }
      }
    } else {
      sportSelect = false;
    }
    return sportSelect!;
  }
}
