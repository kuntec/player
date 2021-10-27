import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/tournament_data.dart';
import 'package:player/screens/tournament_participants.dart';
import 'package:player/venue/choose_sport.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTournament extends StatefulWidget {
  // dynamic selectedSport;
  // dynamic sportName;
  // AddTournament({this.selectedSport, this.sportName});

  @override
  _AddTournamentState createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  bool? isMyTournamentSelected = false;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? time;

  // var txtStartDate = "Select Start Date";
  // var txtEndDate = "Select End Date";
  // var txtTime = "Select Time";

  Tournament? tournament;

  var organizerName;
  var organizerNumber;
  var tournamentName;
  var entryFees;
  var noOfMembers;
  var noOfOvers;
  var ageLimit;
  var address;
  var locationLink;
  var prizeDetails;
  var otherInfo;

  TextEditingController textSportController = new TextEditingController();
  var selectedSport;
  bool isCricket = false;

  TextEditingController textStartDateController = new TextEditingController();
  TextEditingController textEndDateController = new TextEditingController();
  TextEditingController textStartTimeController = new TextEditingController();
  TextEditingController textEndTimeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Host Tournament")),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBaseColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                        setState(() {
                          isMyTournamentSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabLeftDecoration.copyWith(
                            color: isMyTournamentSelected!
                                ? Colors.white
                                : kBaseColor),
                        child: Center(
                          child: Text(
                            "New Tournament",
                            style: TextStyle(
                                color: isMyTournamentSelected!
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
                        setState(() {
                          isMyTournamentSelected = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabRightDecoration.copyWith(
                            color: isMyTournamentSelected!
                                ? kBaseColor
                                : Colors.white),
                        child: Center(
                          child: Text(
                            "My Tournament",
                            style: TextStyle(
                                color: isMyTournamentSelected!
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
            isMyTournamentSelected! ? myTournament() : addTournamentForm()
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image : $e");
    }
  }

  File? image;

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
        });
      },
      items: ballTypes.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
    );
  }

  String? tournamentCategoryValue;
  var tournamentCategories = [
    "Tennis Cricket",
    "Box Cricket",
    "Season Cricket",
    "Test Cricket"
  ];

  Widget buildTournamentCategory() {
    return DropdownButton(
      value: tournamentCategoryValue != null ? tournamentCategoryValue : null,
      hint: Text("Select Tournament Category"),
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
          tournamentCategoryValue = newValue!;
        });
      },
      items: tournamentCategories.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
    );
  }

  Widget addTournamentForm() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              pickImage();
            },
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: image != null
                  ? Image.file(
                      image!,
                      width: 280,
                      height: 150,
                      fit: BoxFit.fill,
                    )
                  : FlutterLogo(size: 100),
            ),
          ),
          GestureDetector(
            onTap: () async {
              print("Camera Clicked");
              // pickedFile =
              //     await ImagePicker().getImage(source: ImageSource.gallery);
              pickImage();
            },
            child: Container(
              child: Icon(
                Icons.camera_alt_outlined,
                size: 30,
                color: kBaseColor,
              ),
            ),
          ),
          TextField(
            onChanged: (value) {
              organizerName = value;
            },
            decoration: InputDecoration(
                labelText: "Organizer Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              organizerNumber = value;
            },
            decoration: InputDecoration(
                labelText: "Organizer Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              tournamentName = value;
            },
            decoration: InputDecoration(
                labelText: "Tournament Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          SizedBox(
            height: k20Margin,
          ),
          Container(
              child: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    pickDate(context, true);
                  },
                  controller: textStartDateController,
                  decoration: InputDecoration(
                      labelText: "Start Date",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
                // child: GestureDetector(
                //   onTap: () {
                //     pickDate(context, true);
                //   },
                //   child: Text(
                //     txtStartDate,
                //   ),
                // ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    pickDate(context, false);
                  },
                  controller: textEndDateController,
                  decoration: InputDecoration(
                      labelText: "End Date",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
            ],
          )),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    onChanged: (value) {
                      entryFees = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Entry Fees",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      pickTime(context, true);
                    },
                    controller: textStartTimeController,
                    decoration: InputDecoration(
                        labelText: "Start Time",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      pickTime(context, false);
                    },
                    controller: textEndTimeController,
                    decoration: InputDecoration(
                        labelText: "End Time",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
              ],
            ),
          ),
          TextField(
            onChanged: (value) {
              noOfMembers = value;
            },
            decoration: InputDecoration(
                labelText: "Number of team members",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              ageLimit = value;
            },
            decoration: InputDecoration(
                labelText: "Any Age Requirement",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              address = value;
            },
            decoration: InputDecoration(
                labelText: "Tournament Location (Address)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              locationLink = value;
            },
            decoration: InputDecoration(
                labelText: "Location Link",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              prizeDetails = value;
            },
            decoration: InputDecoration(
                labelText: "Prize Details",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              otherInfo = value;
            },
            decoration: InputDecoration(
                labelText: "Any Other Information",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: textSportController,
            readOnly: true,
            onTap: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChooseSport(
                            selectedSport: selectedSport,
                          )));

              selectedSport = result;

              textSportController.text = selectedSport.sportName;

              if (selectedSport.sportName.toString().toLowerCase() ==
                  "cricket") {
                Utility.showToast(
                    "This is selected ${selectedSport.sportName} ${selectedSport.id}");
                isCricket = true;
              } else {
                isCricket = false;
              }
              setState(() {});
            },
            decoration: InputDecoration(
                labelText: "Select Sport",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          SizedBox(height: 10.0),
          isCricket ? buildBallTypeData() : SizedBox(height: 1.0),
          SizedBox(height: 10.0),
          isCricket ? buildTournamentCategory() : SizedBox(height: 1.0),
          isCricket
              ? TextField(
                  onChanged: (value) {
                    noOfOvers = value;
                  },
                  decoration: InputDecoration(
                      labelText: "Number of Overs",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                )
              : SizedBox(height: 1.0),
          SizedBox(height: k20Margin),
          RoundedButton(
            title: "Create Tournament",
            color: kBaseColor,
            txtColor: Colors.white,
            minWidth: 250,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var playerId = prefs.get("playerId");
              if (ballTypeValue == null) {
                ballTypeValue = "";
              }
              if (tournamentCategoryValue == null) {
                tournamentCategoryValue = "";
              }
              if (noOfOvers == null) {
                noOfOvers = "";
              }
              if (locationLink == null) {
                locationLink = "";
              }

              tournament = new Tournament();
              tournament!.playerId = playerId!.toString();
              tournament!.organizerName = organizerName.toString();
              tournament!.organizerNumber = organizerNumber.toString();
              tournament!.tournamentName = tournamentName.toString();
              tournament!.startDate = textStartDateController.text;
              tournament!.endDate = textEndDateController.text;
              tournament!.entryFees = entryFees.toString();
              tournament!.startTime = textStartTimeController.text;
              tournament!.endTime = textEndTimeController.text;
              tournament!.noOfMembers = noOfMembers.toString();
              tournament!.ageLimit = ageLimit.toString();
              tournament!.address = address.toString();
              tournament!.prizeDetails = prizeDetails.toString();
              tournament!.otherInfo = otherInfo.toString();
              tournament!.playerName = prefs.getString("playerName");
              tournament!.locationId = "1";
              tournament!.sportId = selectedSport.id.toString();
              tournament!.sportName = selectedSport.sportName.toString();
              tournament!.createdAt = Utility.getCurrentDate();

              tournament!.ballType = ballTypeValue.toString();
              tournament!.tournamentCategory =
                  tournamentCategoryValue.toString();
              tournament!.noOfOvers = noOfOvers.toString();
              tournament!.locationLink = locationLink.toString();

//            Utility.showToast("Create Tournament");
              if (this.image != null) {
                addTournament(this.image!.path, tournament!);
                Utility.showToast("File Selected Image");
              } else {
                Utility.showToast("Please Select Image");
              }

              print("Create Tournament");
              //_load = false;
              //showLoadingIndicator("Loading....");
            },
          ),
        ],
      ),
    );
  }

  var _load;
  void showLoadingIndicator(String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: _load
                  ? Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.black.withOpacity(0.8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _getLoadingIndicator(),
                            _getHeading(),
                            _getText('Text')
                          ]))
                  : null);
        });
  }

  Widget _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: CircularProgressIndicator(strokeWidth: 3),
            width: 32,
            height: 32),
        padding: EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading() {
    return Padding(
        child: Text(
          'Please wait …',
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Widget _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }

  Future pickDate(BuildContext context, bool isStart) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;
    setState(() {
      startDate = newDate;
      if (startDate == null) {
      } else {
        if (isStart) {
          textStartDateController.text =
              "${startDate!.day}-${startDate!.month}-${startDate!.year}";
        } else {
          textEndDateController.text =
              "${startDate!.day}-${startDate!.month}-${startDate!.year}";
        }

        setState(() {});
        print("Date selected day ${startDate!.weekday}");
        //txtDate = "${date!.day}-${date!.month}-${date!.year}";
      }
    });
  }

  Future pickTime(BuildContext context, bool isStart) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() {
      time = newTime;
      if (time == null) {
        //textStartTimeController.text = "Select Time";
      } else {
        if (isStart) {
          textStartTimeController.text = "${time!.hour}:${time!.minute}";
        } else {
          textEndTimeController.text = "${time!.hour}:${time!.minute}";
        }
      }
    });
  }

  addTournament(String filePath, Tournament tournament) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic status = await apiCall.addTournament(filePath, tournament);

      if (status == null) {
        print("Tournament null");
      } else {
        if (status!) {
          print("Tournament Success");
          Utility.showToast("Tournament Created Successfully");
          Navigator.pop(context);
        } else {
          print("Tournament Failed");
        }
      }
    }
  }
  //My Tournament Tab Widget

  Widget myTournament() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(5.0),
      child: FutureBuilder(
        future: getMyTournaments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                return tournamentItem(snapshot.data[index]);
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
    );
  }

  List<Tournament>? tournaments;

  Future<List<Tournament>?> getMyTournaments() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      TournamentData tournamentData =
          await apiCall.getMyTournament(playerId.toString());
      if (tournamentData.tournaments != null) {
        tournaments = tournamentData.tournaments!;
        //setState(() {});
      }

      if (tournamentData.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(tournamentData.message!);
      }
    }
    return tournaments;
  }

  Widget tournamentItem(dynamic tournament) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TournamentParticipants(event: tournament, type: "0")));
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
//      padding: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        // height: 200,
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    height: 85.0,
                    width: 85.0,
                    // child: SvgPicture.network(
                    //   "https://www.svgrepo.com/show/2046/dog.svg",
                    //   placeholderBuilder: (context) =>
                    //       CircularProgressIndicator(),
                    //   height: 110.0,
                    //   width: 110,
                    //   fit: BoxFit.cover,
                    // ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        APIResources.IMAGE_URL + tournament.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 110.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text(
                    tournament.tournamentName,
                    style: TextStyle(
                        color: kBaseColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Start Date: ${tournament.startDate}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Location: ${tournament.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "Location: ${tournament.sportName}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "\u{20B9} ${tournament.entryFees}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  // Text(
                  //   "Time: ${tournament.startTime} to ${tournament.startTime}",
                  //   style: TextStyle(
                  //     color: Colors.grey.shade900,
                  //     fontSize: 14.0,
                  //   ),
                  // ),
                  // SizedBox(height: 5.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget tournamentItem(dynamic tournament) {
  //   return GestureDetector(
  //     onTap: () {
  //       //       Utility.showToast("Tournament Clicked ${tournament.prizeDetails}");
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => TournamentParticipants(
  //                     tournamentId: tournament.id,
  //                   )));
  //     },
  //     child: Container(
  //       margin: EdgeInsets.all(10.0),
  //       decoration: kContainerBoxDecoration,
  //       // height: 150,
  //       child: Stack(
  //         alignment: Alignment.bottomRight,
  //         children: [
  //           Container(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 ClipRRect(
  //                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                   child: Image.network(
  //                     APIResources.IMAGE_URL + tournament.image,
  //                     fit: BoxFit.fill,
  //                   ),
  //                 ),
  //                 SizedBox(height: 20),
  //                 Container(
  //                   margin: EdgeInsets.only(left: 10.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         tournament.tournamentName,
  //                         style: TextStyle(color: kBaseColor, fontSize: 18.0),
  //                       ),
  //                       SizedBox(height: 5),
  //                       Text(
  //                         "Start Date : ${tournament.startDate}",
  //                         style: TextStyle(color: Colors.black, fontSize: 14.0),
  //                       ),
  //                       SizedBox(height: 5),
  //                       // Text(
  //                       //   "End Date : ${tournament.endDate}",
  //                       //   style: TextStyle(color: Colors.black, fontSize: 14.0),
  //                       // ),
  //                       // SizedBox(height: 5),
  //                       // Text(
  //                       //   "Time : ${tournament.timing}",
  //                       //   style: TextStyle(color: Colors.black, fontSize: 14.0),
  //                       // ),
  //                       // SizedBox(height: 5),
  //                       Text(
  //                         "Location : ${tournament.address}",
  //                         style: TextStyle(color: Colors.black, fontSize: 14.0),
  //                       ),
  //                       SizedBox(height: 10),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 50,
  //             right: 20,
  //             child: Container(
  //               child: Text(
  //                 "Rs ${tournament.prizeDetails}",
  //                 style: TextStyle(color: kBaseColor, fontSize: 18.0),
  //               ),
  //             ),
  //           ),
  //           Container(
  //             decoration: BoxDecoration(
  //                 color: kBaseColor,
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(15.0),
  //                   bottomRight: Radius.circular(15.0),
  //                 )),
  //             width: 100,
  //             height: 40,
  //             child: Center(
  //               child: Text(
  //                 tournament.sportName,
  //                 style: TextStyle(color: Colors.white, fontSize: 16.0),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // hostActivityItem(dynamic activity) {
  //   return Container(
  //     margin: EdgeInsets.all(10.0),
  //     decoration: kContainerBoxDecoration,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: [
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Expanded(
  //               flex: 4,
  //               child: Container(
  //                 margin: EdgeInsets.all(10.0),
  //                 height: 90.0,
  //                 width: 90.0,
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(25.0),
  //                   child: Image.network(
  //                     APIResources.IMAGE_URL + activity.image,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               flex: 6,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   SizedBox(height: 10.0),
  //                   Text(
  //                     activity.playerName,
  //                     style: TextStyle(
  //                       color: kBaseColor,
  //                       fontSize: 20.0,
  //                     ),
  //                   ),
  //                   SizedBox(height: 10.0),
  //                   Text(
  //                     "Looking For: ${activity.sportName}",
  //                     style: TextStyle(
  //                       color: Colors.grey.shade900,
  //                       fontSize: 14.0,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5.0),
  //                   Text(
  //                     "Location: ${activity.address}",
  //                     style: TextStyle(
  //                       color: Colors.grey.shade900,
  //                       fontSize: 14.0,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5.0),
  //                   Text(
  //                     "Time: ${activity.timing}",
  //                     style: TextStyle(
  //                       color: Colors.grey.shade900,
  //                       fontSize: 14.0,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5.0),
  //                   Text(
  //                     "Date: ${activity.startDate}",
  //                     style: TextStyle(
  //                       color: Colors.grey.shade900,
  //                       fontSize: 14.0,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5.0),
  //                   Text(
  //                     "Ball Type: ${activity.sportName} ",
  //                     style: TextStyle(
  //                       color: Colors.grey.shade900,
  //                       fontSize: 14.0,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5.0),
  //                 ],
  //               ),
  //             ),
  //             Expanded(
  //               flex: 1,
  //               child: Container(
  //                 child: Icon(
  //                   Icons.more_horiz,
  //                   color: kBaseColor,
  //                   size: 20.0,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Container(
  //           decoration: BoxDecoration(
  //               color: kBaseColor,
  //               borderRadius: BorderRadius.only(
  //                 bottomRight: Radius.circular(15.0),
  //                 topLeft: Radius.circular(15.0),
  //               )),
  //           width: 100,
  //           height: 35,
  //           child: Center(
  //             child: Text(
  //               activity.sportName,
  //               style: TextStyle(color: Colors.white, fontSize: 16.0),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
