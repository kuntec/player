import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/location_data.dart';
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
//  late String dob;
  String? gender = "";
  DateTime? date;
  var txtDate = "Select Date";

  TextEditingController txtDateController = new TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 90),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return;
    setState(() {
      date = newDate;
      if (date == null) {
        txtDate = "Select Date";
      } else {
        txtDate = "${date!.day}-${date!.month}-${date!.year}";
      }
      txtDateController.text = txtDate;
    });
  }

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
                SizedBox(height: k20Margin),
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
                        controller: txtDateController,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        onTap: () async {
                          pickDate(context);
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            labelText: "Enter Birthday",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      // TextField(
                      //   keyboardType: TextInputType.text,
                      //   onChanged: (value) {
                      //     dob = value;
                      //   },
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //   ),
                      //   decoration: InputDecoration(
                      //       labelText: "Enter Birthday",
                      //       labelStyle: TextStyle(
                      //         color: Colors.grey,
                      //       )),
                      //   cursorColor: kBaseColor,
                      // ),
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
                      locations != null
                          ? buildLocationData(locations!)
                          : Container(child: Text("Loading...")),
                      isLoading
                          ? CircularProgressIndicator()
                          : RoundedButton(
                              title: "CONTINUE",
                              color: kBaseColor,
                              txtColor: Colors.white,
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                // print(name);
                                // print(widget.phoneNumber);
                                // print(dob);
                                // print(gender);

                                if (this.gender == null) {
                                  Utility.showToast("Please Select Gender");
                                  return;
                                }

                                if (this.selectedLocation == null) {
                                  Utility.showToast("Please Select Location");
                                  return;
                                }

                                setState(() {
                                  isLoading = true;
                                });
                                await addPlayer(
                                    name,
                                    widget.phoneNumber,
                                    txtDateController.text,
                                    gender!,
                                    widget.fuid,
                                    widget.deviceToken,
                                    selectedLocation!.id.toString(),
                                    selectedLocation!.name.toString());
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

  addPlayer(String name, String phoneNumber, String dob, String gender,
      String fuid, String deviceToken, String locationId, String city) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      PlayerData playerData = await apiCall.addPlayer(
          name, phoneNumber, dob, gender, fuid, deviceToken, locationId, city);
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
          String? locationId = playerData.player!.locationId;
          String? city = playerData.player!.city;
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
          prefs.setString("locationId", locationId!);
          prefs.setString("city", city!);
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

  List<Location>? locations;
  getLocation() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      LocationData locationData = await apiCall.getLocation();

      if (locationData.location != null) {
        setState(() {
          locations = locationData.location;
        });
      }
    } else {
      showToast(kInternet);
    }
  }

  Location? selectedLocation;
  Widget buildLocationData(List<Location> location) {
    return DropdownButton<Location>(
      value: selectedLocation != null ? selectedLocation : null,
      hint: Text("Select Location"),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: kBaseColor,
      ),
      onChanged: (Location? newValue) {
        // this._selectedLK = newValue!;
        setState(() {
          this.selectedLocation = newValue!;
        });
      },
      items: location.map<DropdownMenuItem<Location>>((Location value) {
        return DropdownMenuItem<Location>(
          value: value,
          child: Text(value.name!),
        );
      }).toList(),
    );
  }
}
