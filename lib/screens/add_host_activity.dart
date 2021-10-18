import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/host_activity.dart';
import 'package:player/model/looking_for_data.dart';
import 'package:player/model/sport_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddHost extends StatefulWidget {
  const AddHost({Key? key}) : super(key: key);

  @override
  _AddHostState createState() => _AddHostState();
}

class _AddHostState extends State<AddHost> {
  late String valueChoose;
  // List sports = [
  //   "Cricket",
  //   "Football",
  //   "Vollyball",
  //   "Badminton",
  // ];
  // String dropdownValue = 'Select Sport';
  //
  // String lookingForValue = 'Looking For';
  LookingFor? _selectedLK;
  Data? selectedSport;
  List<LookingFor>? looks;
  List<Data>? sports;
  SportData? sportData;

  bool? isMyGameSelected = false;

  Future<List<LookingFor>> getLookingFor() async {
    APICall apiCall = new APICall();
    List<LookingFor> list = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      LookingForData lookingForData = await apiCall.getLookingFor();
      if (lookingForData.lookingFor != null) {
        list = lookingForData.lookingFor!;
        setState(() {
          looks = list;
//          this._selectedLK = list[0];
        });
      }
    }
    return list;
  }

  Future<List<Data>> getSports() async {
    APICall apiCall = new APICall();
    List<Data> list = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SportData sportData = await apiCall.getSports();
      if (sportData.data != null) {
        list = sportData.data!;
        setState(() {
          sports = list;
//          this.selectedSport = list[0];
        });
      }
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLookingFor();
    getSports();
  }

  Widget buildData(List<LookingFor> data) {
    return DropdownButton<LookingFor>(
      value: this._selectedLK != null ? this._selectedLK : null,
      hint: Text("Select Looking For"),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: kAppColor,
      ),
      onChanged: (LookingFor? newValue) {
        // this._selectedLK = newValue!;
        setState(() {
          this._selectedLK = newValue!;
        });
      },
      items: data.map<DropdownMenuItem<LookingFor>>((LookingFor value) {
        return DropdownMenuItem<LookingFor>(
          value: value,
          child: Text(value.lookingFor!),
        );
      }).toList(),
    );
  }

  Widget buildSportData(List<Data> data) {
    return DropdownButton<Data>(
      value: selectedSport != null ? selectedSport : null,
      hint: Text("Select Sport"),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: kAppColor,
      ),
      onChanged: (Data? newValue) {
        // this._selectedLK = newValue!;
        setState(() {
          this.selectedSport = newValue!;
        });
      },
      items: data.map<DropdownMenuItem<Data>>((Data value) {
        return DropdownMenuItem<Data>(
          value: value,
          child: Text(value.sportName!),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Center(child: Text("Host Activity")),
        actions: [
          // Container(
          //   margin: EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15.0),
          //     color: Colors.white,
          //   ),
          //   width: 100,
          //   height: 300,
          //   child: Center(
          //     child: Text(
          //       "My Games",
          //       style: TextStyle(color: kAppColor, fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // SizedBox(height: k20Margin),
              // Container(
              //   decoration: kContainerBox,
              //   height: 40,
              //   child: Row(
              //     children: [
              //       Center(
              //         child: Text(
              //           "Create New Activity",
              //           style: TextStyle(
              //               color:
              //                   isMyGameSelected! ? kBaseColor : Colors.white,
              //               fontSize: 14.0),
              //         ),
              //       ),
              //       Center(
              //         child: Text(
              //           "My Games",
              //           style: TextStyle(
              //               color:
              //                   isMyGameSelected! ? Colors.white : kBaseColor,
              //               fontSize: 14.0),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: k20Margin),

              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          print("Create New Activity");
                          setState(() {
                            isMyGameSelected = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: kContainerTabLeftDecoration.copyWith(
                              color: isMyGameSelected!
                                  ? Colors.white
                                  : kBaseColor),
                          child: Center(
                            child: Text(
                              "New Activity",
                              style: TextStyle(
                                  color: isMyGameSelected!
                                      ? kBaseColor
                                      : Colors.white,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          print("My Games");
                          setState(() {
                            isMyGameSelected = true;
                          });
                          getMyHostActivity();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: kContainerTabRightDecoration.copyWith(
                              color: isMyGameSelected!
                                  ? kBaseColor
                                  : Colors.white),
                          child: Center(
                            child: Text(
                              "My Games",
                              style: TextStyle(
                                  color: isMyGameSelected!
                                      ? Colors.white
                                      : kBaseColor,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Text(
              //   "KINDLY ADD YOUR DETAILS",
              //   style: const TextStyle(
              //     color: const Color(0xff000000),
              //     fontWeight: FontWeight.w600,
              //     fontFamily: "Roboto",
              //     fontStyle: FontStyle.normal,
              //     fontSize: 20.8,
              //   ),
              //   textAlign: TextAlign.left,
              // ),
              isMyGameSelected!
                  ? Container(
                      height: 700,
                      padding: EdgeInsets.all(20.0),
                      child: FutureBuilder(
                        future: getMyHostActivity(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text('Loading....'),
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            print("Has Data ${snapshot.data.length}");
                            // return Container(
                            //   child: Center(
                            //     child: Text('Yes Data ${snapshot.data}'),
                            //   ),
                            // );
                            return ListView.builder(
                              padding: EdgeInsets.only(bottom: 110),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return hostActivityItem(snapshot.data[index]);
                              },
                            );
                          } else {
                            return Container(
                              child: Center(
                                child: Text('No Data'),
                              ),
                            );
                          }
                        },
                      ),
                    )

                  //hostActivityItem(activity)
                  // ListView.separated(
                  //     itemBuilder: (context, index) {
                  //       final activity = activities![index];
                  //       return ListTile(
                  //         title: Text("Player Name = ${activity.playerName}"),
                  //       );
                  //     },
                  //     separatorBuilder: (context, index) => Divider(),
                  //     itemCount: activities!.length)
                  : Container(
                      decoration: kContainerBoxDecoration,
                      margin: EdgeInsets.all(20.0),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          sports != null
                              ? buildSportData(sports!)
                              : CircularProgressIndicator(),

                          looks != null
                              ? buildData(looks!)
                              : CircularProgressIndicator(),

                          SizedBox(height: k20Margin),
//                    looks! == null ? Text("no Data") : buildData(looks!),
                          // FutureBuilder<List<LookingFor>>(
                          //     future: getLookingFor(),
                          //     builder: (context, snapshot) {
                          //       final data = snapshot.data;
                          //       switch (snapshot.connectionState) {
                          //         case ConnectionState.waiting:
                          //           return CircularProgressIndicator();
                          //         default:
                          //           if (snapshot.hasError) {
                          //             return Text("Some Error");
                          //           } else {
                          //             return buildData(data!);
                          //           }
                          //       }
                          //       return buildData(data!);
                          //     }),

                          // DropdownButton<LookingFor>(
                          //   value: selectedLK,
                          //   isExpanded: true,
                          //   icon: const Icon(Icons.keyboard_arrow_down),
                          //   iconSize: 24,
                          //   elevation: 16,
                          //   style: const TextStyle(color: Colors.deepPurple),
                          //   underline: Container(
                          //     height: 2,
                          //     color: kAppColor,
                          //   ),
                          //   onChanged: (LookingFor? newValue) {
                          //     setState(() {
                          //       selectedLK = newValue!;
                          //     });
                          //   },
                          //   items: looks.map<DropdownMenuItem<LookingFor>>(
                          //       (LookingFor value) {
                          //     return DropdownMenuItem<LookingFor>(
                          //       value: value,
                          //       child: Text(value.lookingFor!),
                          //     );
                          //   }).toList(),
                          // ),

                          // DropdownButton<String>(
                          //   value: dropdownValue,
                          //   isExpanded: true,
                          //   icon: const Icon(Icons.keyboard_arrow_down),
                          //   iconSize: 24,
                          //   elevation: 16,
                          //   style: const TextStyle(color: Colors.deepPurple),
                          //   underline: Container(
                          //     height: 2,
                          //     color: kAppColor,
                          //   ),
                          //   onChanged: (String? newValue) {
                          //     setState(() {
                          //       dropdownValue = newValue!;
                          //     });
                          //   },
                          //   items: <String>[
                          //     'Select Sport',
                          //     'Cricket',
                          //     'Football',
                          //     'Badminton',
                          //     'Tennis'
                          //   ].map<DropdownMenuItem<String>>((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          // ),

                          // FutureBuilder<List<LookingFor>>(
                          //     future: getLookingFor(),
                          //     builder: (context, snapshot) {
                          //       final data = snapshot.data;
                          //       switch (snapshot.connectionState) {
                          //         case ConnectionState.waiting:
                          //           return CircularProgressIndicator();
                          //         default:
                          //           if (snapshot.hasError) {
                          //             return Text("Some Error");
                          //           } else {
                          //             return buildData(data!);
                          //           }
                          //       }
                          //       return buildData(data!);
                          //     }),
                          // FutureBuilder<dynamic>(
                          //     future: getLookingFor(),
                          //     builder: (BuildContext context,
                          //         AsyncSnapshot<dynamic> snapshot) {
                          //       if (snapshot.hasData) {
                          //         print(snapshot.data!.lookingFor!.length);
                          //         return DropdownButton<dynamic>(
                          //           value: selectedLK,
                          //           hint: Text("Select Looking For"),
                          //           onChanged: (value) {
                          //             selectedLK = value;
                          //           },
                          //           items: snapshot.data!.lookingFor
                          //               .map(
                          //                 (lk) => DropdownMenuItem<dynamic>(
                          //                   child: Text(lk.lookingFor!),
                          //                   value: lk.lookingForValue,
                          //                 ),
                          //               )
                          //               .toList(),
                          //         );
                          //       } else {
                          //         return Text("No Data");
                          //       }
                          //     }),

                          // DropdownButton(
                          //   value: lookingForValue,
                          //   hint: Text("Select Looking For"),
                          //   onChanged: (value) {
                          //     lookingForValue = value.toString();
                          //   },
                          //   items: looks
                          //       .map(
                          //         (map) => DropdownMenuItem(
                          //           child: Text(map.lookingFor!),
                          //           value: map.lookingForValue,
                          //         ),
                          //       )
                          //       .toList(),
                          // ),
                          // SizedBox(height: k20Margin),
                          // DropdownButton<String>(
                          //   value: lookingForValue,
                          //   isExpanded: true,
                          //   icon: const Icon(Icons.keyboard_arrow_down),
                          //   iconSize: 24,
                          //   elevation: 16,
                          //   style: const TextStyle(color: Colors.deepPurple),
                          //   underline: Container(
                          //     height: 2,
                          //     color: kAppColor,
                          //   ),
                          //   onChanged: (String? newValue) {
                          //     setState(() {
                          //       lookingForValue = newValue!;
                          //     });
                          //   },
                          //   items: <String>[
                          //     'Looking For',
                          //     'Opponent To Play',
                          //     'Team to Join',
                          //     'Player to Join',
                          //     'Team Player to Join'
                          //   ].map<DropdownMenuItem<String>>((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          // ),
                          //SizedBox(height: k20Margin),
                          this.selectedSport != null
                              ? this.selectedSport!.sportName!.toLowerCase() ==
                                          "cricket" ||
                                      this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "tennis"
                                  ? TextField(
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        ballType = value;
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: kTextFieldDecoration.copyWith(
                                          hintText: 'Ball Type'),
                                      cursorColor: kBaseColor,
                                    )
                                  : SizedBox(width: 1.0)
                              : SizedBox(width: 1.0),

                          SizedBox(height: k20Margin),
                          TextField(
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              area = value;
                            },
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration:
                                kTextFieldDecoration.copyWith(hintText: 'AREA'),
                            cursorColor: kBaseColor,
                          ),
                          SizedBox(height: k20Margin),

                          RoundedButton(
                            title: txtDate,
                            color: Colors.white,
                            txtColor: kBaseColor,
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              pickDate(context);
                            },
                          ),
                          SizedBox(height: k20Margin),
                          RoundedButton(
                            title: txtTime,
                            color: Colors.white,
                            txtColor: kBaseColor,
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              pickTime(context);
                            },
                          ),
                          SizedBox(height: k20Margin),
//                     TextField(
//                       onTap: () {
//                         print("Date is tap");
//                         pickDate(context);
//                       },
//                       keyboardType: TextInputType.text,
//                       onChanged: (value) {},
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                       decoration:
//                           kTextFieldDecoration.copyWith(hintText: 'DATE'),
//                       cursorColor: kBaseColor,
//                     ),
//                     SizedBox(
//                       height: k20Margin,
//                     ),
//                     TextField(
//                       keyboardType: TextInputType.text,
//                       onChanged: (value) {},
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                       decoration:
//                           kTextFieldDecoration.copyWith(hintText: 'TIME'),
//                       cursorColor: kBaseColor,
//                     ),
// //                    Text("Select Gender"),
//                     SizedBox(
//                       height: k20Margin,
//                     ),

                          RoundedButton(
                            title: "CREATE ACTIVITY",
                            color: kBaseColor,
                            txtColor: Colors.white,
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              // print(this._selectedLK!.lookingForValue!);
                              // print(this.selectedSport!.sportName!);
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              playerId = prefs.get("playerId");
                              playerName = prefs.get("playerName");
                              //locationId = prefs.get("locationId");
                              locationId = "1";
                              sportId = this.selectedSport!.id!;
                              sportName = this.selectedSport!.sportName!;
                              lookingForId = this._selectedLK!.id!;
                              lookingFor = this._selectedLK!.lookingFor!;
                              lookingForValue =
                                  this._selectedLK!.lookingForValue!;
                              startDate = txtDate;
                              timing = txtTime;
                              createdAt = Utility.getCurrentDate();

                              if (ballType == null) {
                                ballType = "";
                              }

                              activity = new Activity();
                              activity!.sportId = sportId.toString();
                              activity!.sportName = sportName;
                              activity!.lookingForId = lookingForId.toString();
                              activity!.lookingFor = lookingFor;
                              activity!.lookingForValue = lookingForValue;
                              activity!.area = area;
                              activity!.startDate = startDate;
                              activity!.timing = timing;
                              activity!.ballType = ballType;
                              activity!.playerId = playerId.toString();
                              activity!.playerName = playerName;
                              activity!.locationId = locationId.toString();
                              activity!.createdAt = createdAt;

                              addHostActivity(activity!);
                            },
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    ));
  }

  Activity? activity;
  var sportId;
  var sportName;
  var lookingForId;
  var lookingFor;
  var lookingForValue;
  var area;
  var startDate;
  var timing;
  var ballType;
  var playerId;
  var playerName;
  var locationId;
  var createdAt;
  var playerImage;

  DateTime? date;
  TimeOfDay? time;
//  var txtDate = TextEditingController();
  var txtDate = "Select Date";
  var txtTime = "Select Time";
  // getText() {
  //   if (date == null) {
  //     setState(() {
  //       txt = "Select Date";
  //     });
  //   } else {
  //     setState(() {
  //       txt = "${date!.day}-${date!.month}-${date!.year}";
  //     });
  //   }
  // }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;
    setState(() {
      date = newDate;
      if (date == null) {
        txtDate = "Select Date";
      } else {
        txtDate = "${date!.day}-${date!.month}-${date!.year}";
      }
    });
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    if (newTime == null) return;
    setState(() {
      time = newTime;
      if (time == null) {
        txtTime = "Select Time";
      } else {
        txtTime = "${time!.hour}:${time!.minute}";
      }
    });
  }

  addHostActivity(Activity activity) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      HostActivity hostActivity = await apiCall.addHostActivity(activity);

      if (hostActivity.status!) {
        print(hostActivity.message!);
        Navigator.pop(context);
      } else {
        print(hostActivity.message!);
      }
    }
  }

  List<Activites>? activities;

  Future<List<Activites>?> getMyHostActivity() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      playerId = prefs.get("playerId");
      playerImage = prefs.get("playerImage");
      print("Player ID $playerId");
      HostActivity hostActivity =
          await apiCall.getMyHostActivity(playerId.toString());
      if (hostActivity.activites != null) {
        activities = hostActivity.activites!;
        //setState(() {});
      }

      if (hostActivity.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(hostActivity.message!);
      }
    }
    return activities;
  }

  hostActivityItem(dynamic activity) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: kContainerBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  height: 90.0,
                  width: 90.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.network(
                      APIResources.IMAGE_URL + playerImage,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Text(
                      activity.playerName,
                      style: TextStyle(
                        color: kBaseColor,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Looking For: ${activity.lookingFor}",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Location: ${activity.area}",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Time: ${activity.timing}",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Date: ${activity.startDate}",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      activity.ballType != null
                          ? "Ball Type: ${activity.ballType} "
                          : "",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Icon(
                    Icons.more_horiz,
                    color: kBaseColor,
                    size: 20.0,
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: kBaseColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                )),
            width: 100,
            height: 35,
            child: Center(
              child: Text(
                activity.sportName,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Widget stackExample() {
//     return Container(
//       margin: EdgeInsets.all(10.0),
//       padding: EdgeInsets.only(bottom: 10.0),
//       decoration: kContainerBoxDecoration,
//       // height: 200,
//       child: Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(10.0),
//                   height: 85.0,
//                   width: 85.0,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(25.0),
//                     child: Image(
//                       image: AssetImage("assets/images/demo.jpg"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(width: 10.0),
//                     Icon(
//                       Icons.circle,
//                       color: Colors.green,
//                       size: 14.0,
//                     ),
//                     SizedBox(width: 10.0),
//                     Text(
//                       "2 hours ago",
//                       style: TextStyle(fontSize: 12.0),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 100.0, right: 5.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20.0),
//                 Text(
//                   "Tausif Saiyed",
//                   style: TextStyle(
//                     color: kBaseColor,
//                     fontSize: 20.0,
//                   ),
//                 ),
//                 SizedBox(height: 10.0),
//                 Text(
//                   "Looking For: A Player To Join My Team",
//                   style: TextStyle(
//                     color: Colors.grey.shade900,
//                     fontSize: 14.0,
//                   ),
//                 ),
//                 SizedBox(height: 5.0),
//                 Text(
//                   "Location: Vasna",
//                   style: TextStyle(
//                     color: Colors.grey.shade900,
//                     fontSize: 14.0,
//                   ),
//                 ),
//                 SizedBox(height: 5.0),
//                 Text(
//                   "Time: 6:30 PM",
//                   style: TextStyle(
//                     color: Colors.grey.shade900,
//                     fontSize: 14.0,
//                   ),
//                 ),
//                 SizedBox(height: 5.0),
//                 Text(
//                   "Date: 06-11-2021",
//                   style: TextStyle(
//                     color: Colors.grey.shade900,
//                     fontSize: 14.0,
//                   ),
//                 ),
// //                Row(),
//               ],
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 color: kBaseColor,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(15.0),
//                   topRight: Radius.circular(15.0),
//                 )),
//             width: 100,
//             height: 40,
//             child: Center(
//               child: Text(
//                 "Cricket",
//                 style: TextStyle(color: Colors.white, fontSize: 16.0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}
