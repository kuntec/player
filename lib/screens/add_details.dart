import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/player_data.dart';
import 'package:player/screens/sport_select.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDetails extends StatefulWidget {
  String phoneNumber;
  String fuid;
  String deviceToken;
  AddDetails(
      {required this.phoneNumber,
      required this.fuid,
      required this.deviceToken});

  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  late String name;
  late String dob;
  String? gender = "";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    int _value = 0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: GestureDetector(
          //   child: Icon(Icons.arrow_back),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          title: Text("ADD DETAILS"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: k20Margin,
                ),
                Text(
                  "KINDLY ADD YOUR DETAILS",
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
                  decoration: kServiceBoxItem,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          name = value;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            )),
                        cursorColor: kBaseColor,
                      ),
                      SizedBox(
                        height: k20Margin,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          dob = value;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            labelText: "Enter Birthday",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            )),
                        cursorColor: kBaseColor,
                      ),
                      SizedBox(
                        height: k20Margin,
                      ),
                      // TextField(
                      //   keyboardType: TextInputType.text,
                      //   onChanged: (value) {
                      //     gender = value;
                      //   },
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //   ),
                      //   decoration:
                      //       kTextFieldDecoration.copyWith(hintText: 'GENDER'),
                      //   cursorColor: kBaseColor,
                      // ),
                      Text("Select Gender"),
                      SizedBox(
                        height: k20Margin,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: "Male",
                            groupValue: gender,
                            onChanged: (value) {
                              gender = value.toString();
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                              onTap: () {
                                gender = "Male";
                                setState(() {});
                              },
                              child: Text("Male")),
                          Radio(
                            value: "Female",
                            groupValue: gender,
                            onChanged: (value) {
                              gender = value.toString();
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                              onTap: () {
                                gender = "Female";
                                setState(() {});
                              },
                              child: Text("Female")),
                          Radio(
                            value: "Other",
                            groupValue: gender,
                            onChanged: (value) {
                              gender = value.toString();
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                              onTap: () {
                                gender = "Other";
                                setState(() {});
                              },
                              child: Text("Other")),
                        ],
                      ),
                      isLoading
                          ? CircularProgressIndicator()
                          : RoundedButton(
                              title: "CONTINUE",
                              color: kBaseColor,
                              txtColor: Colors.white,
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                print(name);
                                print(widget.phoneNumber);
                                print(dob);
                                print(gender);
                                setState(() {
                                  isLoading = true;
                                });
                                await addPlayer(name, widget.phoneNumber, dob,
                                    gender!, widget.fuid, widget.deviceToken);
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

  // goToSportSelect() {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (_) => SportSelect()));
  // }

//   void doRegister() async {
//     print('Register click ');
// //    showToast("This is Register");
//
//     // //test user
//     // firstname = "Tausif";
//     // lastname = "Saiyed";
//     // aadhar_no = "123467891235";
//     // gender = "Male";
//     // address = "Vasna";
//     // city = "Baroda";
//     // country = "India";
//     // postcode = "390012";
//
//     APICall call = new APICall();
//
//     if (Utility.checkValidation(firstname)) {
//       showToast('Please enter first name');
//       return;
//     }
//     if (Utility.checkValidation(lastname)) {
//       showToast('Please enter last name');
//       return;
//     }
//
//     if (Utility.checkValidation(aadhar_no)) {
//       showToast('Please enter Aadhar no');
//       return;
//     }
//
//     bool connectivityStatus = await Utility.checkConnectivity();
//     if (connectivityStatus) {
//       User user = new User();
//       user.firstname = firstname;
//       user.lastname = lastname;
//       user.aadhar_no = aadhar_no;
//       user.gender = gender;
//       user.mobile = widget.phonenumber;
//       user.address = address;
//       user.city = city;
//       user.country = country;
//       user.postcode = postcode;
//       user.status = "0";
//       user.user_roles_id = widget.userRole;
//       user.created_at = Utility.getCurrentDate();
//
//       print('Register click ${user.created_at}');
//
//       Register register = await call.register(user);
//
//       if (register.status) {
//         showToast('register Successful, ${register.data.mobile}');
//
//         SharedPreferences preferences = await SharedPreferences.getInstance();
//         preferences.setBool('isLogin', true);
//         preferences.setInt('loginId', register.data.id);
//
//         if (widget.userRole == "2") {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) => HomeScreen(),
//             ),
//           );
//         }
//
//         if (widget.userRole == "3") {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) => DonorHomeScreen(),
//             ),
//           );
//         }
//       } else {
//         showToast('register Failed, ${register.message}');
//       }
//     } else {
//       showToast(kInternet);
//     }
//   }

  addPlayer(String name, String phoneNumber, String dob, String gender,
      String fuid, String deviceToken) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      PlayerData playerData = await apiCall.addPlayer(
          name, phoneNumber, dob, gender, fuid, deviceToken);
      setState(() {
        isLoading = false;
      });
      if (playerData.status!) {
        showToast(playerData.message!);
        // Go to Sport Selection
        // (playerData.player != null) {
        //   String userId = value.user!.uid;

        if (playerData.player != null) {
          int? playerId = playerData.player!.id;
          String? playerName = playerData.player!.name;
          String? mobile = playerData.player!.mobile;
          // String? locationId = playerData.player!.locationId;
          // String? playerImage = playerData.player!.image;
          setState(() {
            isLoading = false;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt("playerId", playerId!);
          prefs.setString("playerName", playerName!);
          prefs.setString("mobile", mobile!);
          prefs.setString("fuid", fuid);
          //prefs.setString("playerImage", playerImage!);
          //prefs.setString("locationId", locationId!);
          prefs.setBool('isLogin', true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SportSelect(
                        player: playerData.player,
                      )));
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(playerData.message!);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showToast(kInternet);
    }
  }
}
