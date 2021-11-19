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

  TextEditingController txtDateController = new TextEditingController();
  TextEditingController txtTimeController = new TextEditingController();

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
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: kBaseColor,
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
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: kBaseColor,
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

  String? ballTypeValue;
  var ballTypes = ["Tennis", "Season", "Others"];

  Widget buildBallTypeData() {
    return DropdownButton(
      value: ballTypeValue != null ? ballTypeValue : null,
      hint: Text("Select Ball Type"),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: kBaseColor,
      ),
      onChanged: (String? newValue) {
        setState(() {
          ballTypeValue = newValue!;
          ballType = ballTypeValue;
        });
      },
      items: ballTypes.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
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
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
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
              isMyGameSelected!
                  ? Container(
                      height: 700,
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
                            if (snapshot.data.length == 0) {
                              return Container(
                                child: Center(
                                  child: Text('No Data'),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                padding: EdgeInsets.only(bottom: 110),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return hostActivityItem(snapshot.data[index]);
                                },
                              );
                            }
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
                  : Container(
                      decoration: kServiceBoxItem,
                      margin: EdgeInsets.all(20.0),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          sports != null
                              ? buildSportData(sports!)
                              : Container(child: Text("Loading...")),
                          this.selectedSport != null
                              ? this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "swimming" ||
                                      this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "cycling" ||
                                      this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "skate" ||
                                      this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "running"
                                  ? Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                          "Looking For - Someone to join me"))
                                  : looks != null
                                      ? buildData(looks!)
                                      : Container(child: Text("Loading..."))
                              : SizedBox.shrink(),
                          // SizedBox(height: k20Margin),
                          this.selectedSport != null
                              ? this.selectedSport!.sportName!.toLowerCase() ==
                                      "cricket"
                                  ? buildBallTypeData()
                                  // ? TextField(
                                  //     keyboardType: TextInputType.text,
                                  //     onChanged: (value) {
                                  //       ballType = value;
                                  //     },
                                  //     style: TextStyle(
                                  //       color: Colors.black,
                                  //     ),
                                  //     decoration: InputDecoration(
                                  //         labelText: "Ball Type",
                                  //         labelStyle: TextStyle(
                                  //           color: Colors.grey,
                                  //         )),
                                  //   )
                                  : SizedBox.shrink()
                              : SizedBox.shrink(),
                          this._selectedLK != null
                              ? this._selectedLK!.lookingFor!.toLowerCase() ==
                                          "a team to join as a player" ||
                                      this
                                              ._selectedLK!
                                              .lookingFor!
                                              .toLowerCase() ==
                                          "a player to join my team"
                                  ? TextField(
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        roleOfPlayer = value;
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                          labelText: "Role of Player",
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                          )),
                                    )
                                  : SizedBox.shrink()
                              : SizedBox.shrink(),
                          TextField(
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              area = value;
                            },
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                labelText: "Area",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          SizedBox(height: kMargin),
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
                                labelText: "Select Date",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          TextField(
                            controller: txtTimeController,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            onTap: () async {
                              pickTime(context);
                            },
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                labelText: "Select Time",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          this.selectedSport != null
                              ? this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "swimming" ||
                                      this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "cycling" ||
                                      this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "skate" ||
                                      this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "running"
                                  ? Container(
                                      alignment: Alignment.topLeft,
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: Text(
                                        "Details",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                  : SizedBox.shrink()
                              : SizedBox.shrink(),
                          this.selectedSport != null
                              ? this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "swimming" ||
                                      this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "cycling" ||
                                      this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "skate" ||
                                      this
                                              .selectedSport!
                                              .sportName!
                                              .toLowerCase() ==
                                          "running"
                                  ? TextFormField(
                                      onChanged: (value) {
                                        details = value;
                                      },
                                      minLines: 3,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        labelText: "",
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                      ))
                                  : SizedBox.shrink()
                              : SizedBox.shrink(),
                          SizedBox(height: k20Margin),
                          isLoading!
                              ? CircularProgressIndicator(
                                  color: kBaseColor,
                                )
                              : RoundedButton(
                                  title: "CREATE ACTIVITY",
                                  color: kBaseColor,
                                  txtColor: Colors.white,
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () async {
                                    if (this.selectedSport == null) {
                                      Utility.showToast("Please Select Sport");
                                      return;
                                    }

                                    if (this
                                            .selectedSport!
                                            .sportName!
                                            .toLowerCase() ==
                                        "cricket") {
                                      if (ballType == null) {
                                        Utility.showToast(
                                            "Please Select Ball Type");
                                        return;
                                      }
                                    } else {
                                      if (ballType == null) {
                                        ballType = "";
                                      }
                                    }

                                    if (area == null ||
                                        area.toString().trim() == "") {
                                      Utility.showToast("Please Select Area");
                                      return;
                                    }

                                    if (date == null) {
                                      Utility.showToast("Please Select Date");
                                      return;
                                    }
                                    if (time == null) {
                                      Utility.showToast("Please Select Time");
                                      return;
                                    }

                                    if (roleOfPlayer == null) {
                                      roleOfPlayer = "";
                                    }

                                    if (details == null) {
                                      details = "";
                                    }

                                    if (this
                                                .selectedSport!
                                                .sportName!
                                                .toLowerCase() ==
                                            "swimming" ||
                                        this
                                                .selectedSport!
                                                .sportName!
                                                .toLowerCase() ==
                                            "cycling" ||
                                        this
                                                .selectedSport!
                                                .sportName!
                                                .toLowerCase() ==
                                            "running" ||
                                        this
                                                .selectedSport!
                                                .sportName!
                                                .toLowerCase() ==
                                            "skate") {
                                      lookingForId = "0";
                                      lookingFor = "Someone to join me";
                                      lookingForValue = "Join";
                                    } else {
                                      if (this._selectedLK == null) {
                                        Utility.showToast(
                                            "Please Select Looking For");
                                        return;
                                      }
                                      lookingForId = this._selectedLK!.id!;
                                      lookingFor =
                                          this._selectedLK!.lookingFor!;
                                      lookingForValue =
                                          this._selectedLK!.lookingForValue!;
                                    }

                                    //Utility.showToast("CREATE ACTIVITY");
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    playerId = prefs.get("playerId");
                                    playerName = prefs.get("playerName");
                                    //locationId = prefs.get("locationId");
                                    locationId = prefs.get("locationId");
                                    sportId = this.selectedSport!.id!;
                                    sportName = this.selectedSport!.sportName!;

                                    startDate = txtDate;
                                    timing = txtTime;
                                    createdAt = DateTime.now().toString();

                                    activity = new Activity();
                                    activity!.sportId = sportId.toString();
                                    activity!.sportName = sportName;
                                    activity!.lookingForId =
                                        lookingForId.toString();
                                    activity!.lookingFor = lookingFor;
                                    activity!.lookingForValue = lookingForValue;
                                    activity!.area = area;
                                    activity!.roleOfPlayer = roleOfPlayer;
                                    activity!.startDate = startDate;
                                    activity!.timing = timing;
                                    activity!.ballType = ballType;
                                    activity!.playerId = playerId.toString();
                                    activity!.playerName = playerName;
                                    activity!.locationId =
                                        locationId.toString();
                                    activity!.createdAt = createdAt;
                                    //_onLoading();
                                    addHostActivity();
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
  var details;
  var roleOfPlayer;
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
  bool? isLoading = false;
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
      txtDateController.text = txtDate;
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
      txtTimeController.text = txtTime;
    });
  }

  // void _onLoading() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: new Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             new CircularProgressIndicator(),
  //             new Text("Loading"),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //
  //   // new Future.delayed(new Duration(seconds: 3), () {
  //   //   Navigator.pop(context); //pop dialog
  //   // });
  // }

  addHostActivity() async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      HostActivity hostActivity = await apiCall.addHostActivity(activity!);
      setState(() {
        isLoading = false;
      });
      if (hostActivity.status!) {
        print(hostActivity.message!);

        Utility.showToast(hostActivity.message!);
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context, true);
      } else {
        print(hostActivity.message!);
        Utility.showToast(hostActivity.message!);
      }
    }
  }

  List<Activity>? activities;

  Future<List<Activity>?> getMyHostActivity() async {
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
        activities = activities!.reversed.toList();
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
    return GestureDetector(
      onTap: () {
        //Utility.showToast("Show Details ${activity.playerImage}");
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: kContainerBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Utility.showToast("Show More");
                showPopup();
              },
              child: Container(
                child: Icon(
                  Icons.more_horiz,
                  color: kBaseColor,
                  size: 20.0,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: 95.0,
                    width: 95.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        activity.playerImage == null
                            ? APIResources.AVATAR_IMAGE
                            : APIResources.IMAGE_URL + activity.playerImage,
                        fit: BoxFit.cover,
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
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Looking For: ${activity.lookingFor}",
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Location: ${activity.area}",
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Time: ${activity.timing}",
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Date: ${activity.startDate}",
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        activity.ballType != null
                            ? "Ball Type: ${activity.ballType} "
                            : "",
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     //Utility.showToast("Hello");
                //     //showPopup();
                //   },
                //   child: Expanded(
                //     flex: 1,
                //     child: Container(
                //       child: Icon(
                //         Icons.more_horiz,
                //         color: kBaseColor,
                //         size: 20.0,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: kBaseColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  )),
              width: 100,
              height: 35,
              child: Center(
                child: Text(
                  activity.sportName,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showPopup() {
    PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'edit',
            child: Text('Edit'),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Text('Delete'),
          )
        ];
      },
      onSelected: (String value) {
        print('You Click on po up menu item');
      },
    );
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return SimpleDialog(
    //         title: Text("This is title"),
    //         children: [
    //           Container(
    //             width: 100,
    //             height: 100,
    //             color: Colors.red,
    //             child: Center(
    //               child: Text(
    //                 "Dialog",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //             ),
    //           ),
    //         ],
    //       );
    //     });
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
