import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/custom_button.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/host_activity.dart';
import 'package:player/model/looking_for_data.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/screens/edit_host_activity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditHost extends StatefulWidget {
  dynamic activity;

  EditHost({required this.activity});

  @override
  _EditHostState createState() => _EditHostState();
}

class _EditHostState extends State<EditHost> {
  LookingFor? _selectedLK;
  Data? selectedSport;
  List<LookingFor>? looks;
  List<Data>? sports;
  SportData? sportData;

  TextEditingController txtDateController = new TextEditingController();
  TextEditingController txtTimeController = new TextEditingController();
  TextEditingController txtAreaController = new TextEditingController();
  TextEditingController txtRoleController = new TextEditingController();
  TextEditingController txtDetailsController = new TextEditingController();

  Future<List<LookingFor>> getLookingFor() async {
    APICall apiCall = new APICall();
    List<LookingFor> list = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      LookingForData lookingForData = await apiCall.getLookingFor();
      if (lookingForData.lookingFor != null) {
        list = lookingForData.lookingFor!;
        looks = list;
        for (var l in looks!) {
          if (l.id.toString() == widget.activity!.lookingForId.toString()) {
            this._selectedLK = l;
          }
        }
        setState(() {});
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
        sports = list;
        for (var s in sports!) {
          if (s.id.toString() == widget.activity!.sportId.toString()) {
            this.selectedSport = s;
          }
        }
        setState(() {});
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
    txtDateController.text = widget.activity!.startDate.toString();
    if (widget.activity!.ballType != null) {
      ballTypeValue = widget.activity!.ballType;
    }

    txtAreaController.text = widget.activity!.area;
    if (widget.activity!.roleOfPlayer != null) {
      txtRoleController.text = widget.activity!.roleOfPlayer;
    }
    if (widget.activity!.details != null) {
      txtDetailsController.text = widget.activity!.details;
    }

    txtTimeController.text = widget.activity!.timing.toString();
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
          // ballType = ballTypeValue;
        });
      },
      items: ballTypes.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
    );
  }

  Activity? activity;
  var sportId;
  var sportName;
  var lookingForId;
  var lookingFor;
  var lookingForValue;
//  var area;
  // var details;
  // var roleOfPlayer;
  var startDate;
  var timing;
//  var ballType;
  var playerId;
  var playerName;
  var locationId;
  var createdAt;
  var playerImage;

  DateTime? date;
  TimeOfDay? time;
  bool? isLoading = false;
//  var txtDate = TextEditingController();
//   var txtDate = "Select Date";
//   var txtTime = "Select Time";
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
        // txtDate = "Select Date";
      } else {
        txtDateController.text = "${date!.day}-${date!.month}-${date!.year}";
      }
      // txtDateController.text = txtDate;
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
        // txtTime = "Select Time";
      } else {
        txtTimeController.text = "${time!.hour}:${time!.minute}";
      }
      // txtTimeController.text = txtTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Edit Host Activity ${widget.activity.id}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            editForm(),
          ],
        ),
      ),
    ));
  }

  editForm() {
    return Container(
      decoration: kServiceBoxItem,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          sports != null
              ? buildSportData(sports!)
              : Container(child: Text("Loading...")),
          this.selectedSport != null
              ? this.selectedSport!.sportName!.toLowerCase() == "swimming" ||
                      this.selectedSport!.sportName!.toLowerCase() ==
                          "cycling" ||
                      this.selectedSport!.sportName!.toLowerCase() == "skate" ||
                      this.selectedSport!.sportName!.toLowerCase() == "running"
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text("Looking For - Someone to join me"))
                  : looks != null
                      ? buildData(looks!)
                      : Container(child: Text("Loading..."))
              : SizedBox.shrink(),
          // SizedBox(height: k20Margin),
          this.selectedSport != null
              ? this.selectedSport!.sportName!.toLowerCase() == "cricket"
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
                      this._selectedLK!.lookingFor!.toLowerCase() ==
                          "a player to join my team"
                  ? TextField(
                      keyboardType: TextInputType.text,
                      controller: txtRoleController,
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
            controller: txtAreaController,
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
              ? this.selectedSport!.sportName!.toLowerCase() == "swimming" ||
                      this.selectedSport!.sportName!.toLowerCase() ==
                          "cycling" ||
                      this.selectedSport!.sportName!.toLowerCase() == "skate" ||
                      this.selectedSport!.sportName!.toLowerCase() == "running"
                  ? Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Details",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : SizedBox.shrink()
              : SizedBox.shrink(),
          this.selectedSport != null
              ? this.selectedSport!.sportName!.toLowerCase() == "swimming" ||
                      this.selectedSport!.sportName!.toLowerCase() ==
                          "cycling" ||
                      this.selectedSport!.sportName!.toLowerCase() == "skate" ||
                      this.selectedSport!.sportName!.toLowerCase() == "running"
                  ? TextFormField(
                      controller: txtDetailsController,
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
                  title: "UPDATE ACTIVITY",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    if (this.selectedSport == null) {
                      Utility.showToast("Please Select Sport");
                      return;
                    }

                    if (this.selectedSport!.sportName!.toLowerCase() ==
                        "cricket") {
                      if (ballTypeValue == null) {
                        Utility.showToast("Please Select Ball Type");
                        return;
                      }
                    } else {
                      if (ballTypeValue == null) {
                        ballTypeValue = "";
                      }
                    }

                    if (txtAreaController.text.isEmpty) {
                      Utility.showToast("Please Select Area");
                      return;
                    }

                    if (txtDateController.text.isEmpty) {
                      Utility.showToast("Please Select Date");
                      return;
                    }
                    if (txtTimeController.text.isEmpty) {
                      Utility.showToast("Please Select Time");
                      return;
                    }

                    if (txtRoleController.text == null) {
                      txtRoleController.text = "";
                    }

                    if (txtDetailsController.text == null) {
                      txtDetailsController.text = "";
                    }

                    if (this.selectedSport!.sportName!.toLowerCase() ==
                            "swimming" ||
                        this.selectedSport!.sportName!.toLowerCase() ==
                            "cycling" ||
                        this.selectedSport!.sportName!.toLowerCase() ==
                            "running" ||
                        this.selectedSport!.sportName!.toLowerCase() ==
                            "skate") {
                      lookingForId = "0";
                      lookingFor = "Someone to join me";
                      lookingForValue = "Join";
                    } else {
                      if (this._selectedLK == null) {
                        Utility.showToast("Please Select Looking For");
                        return;
                      }
                      lookingForId = this._selectedLK!.id!;
                      lookingFor = this._selectedLK!.lookingFor!;
                      lookingForValue = this._selectedLK!.lookingForValue!;
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

                    // startDate = txtDate;
                    // timing = txtTime;
                    createdAt = DateTime.now().toString();

                    activity = widget.activity;
                    activity!.sportId = sportId.toString();
                    activity!.sportName = sportName;
                    activity!.lookingForId = lookingForId.toString();
                    activity!.lookingFor = lookingFor;
                    activity!.lookingForValue = lookingForValue;
                    activity!.area = txtAreaController.text;
                    activity!.roleOfPlayer = txtRoleController.text;
                    activity!.startDate = txtDateController.text;
                    activity!.timing = txtTimeController.text;
                    activity!.ballType = ballTypeValue;
                    activity!.playerId = playerId.toString();
                    activity!.playerName = playerName;
                    activity!.locationId = locationId.toString();
                    activity!.createdAt = createdAt;
                    activity!.details = txtDetailsController.text;
                    //_onLoading();
                    updateHostActivity();
                  },
                ),
        ],
      ),
    );
  }

  updateHostActivity() async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      HostActivity hostActivity = await apiCall.updateHostActivity(activity!);
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
}
