import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/custom_button.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/model/tournament_data.dart';
import 'package:player/screens/edit_tournament.dart';
import 'package:player/screens/tournament_participants.dart';
import 'package:player/venue/choose_sport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class EditTournament extends StatefulWidget {
  dynamic tournament;
  EditTournament({required this.tournament});

  @override
  _EditTournamentState createState() => _EditTournamentState();
}

class _EditTournamentState extends State<EditTournament> {
  bool? isLoading = false;
  Tournament? tournament;

  TextEditingController textSportController = new TextEditingController();
  var selectedSport;
  bool isCricket = false;
  bool isBoxCricket = false;

  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? time;
  File? image;

  String? ballTypeValue;
  var ballTypes = ["Tennis", "Season", "Others"];

  TextEditingController textStartDateController = new TextEditingController();
  TextEditingController textEndDateController = new TextEditingController();
  TextEditingController textStartTimeController = new TextEditingController();
  TextEditingController textEndTimeController = new TextEditingController();

  TextEditingController noOverCtrl = new TextEditingController();
  TextEditingController orgNameCtrl = new TextEditingController();
  TextEditingController primNumberCtrl = new TextEditingController();
  TextEditingController secNumberCtrl = new TextEditingController();
  TextEditingController tournamentNameCtrl = new TextEditingController();
  TextEditingController entryFeesCtrl = new TextEditingController();
  TextEditingController noMemberCtrl = new TextEditingController();
  TextEditingController ageCtrl = new TextEditingController();
  TextEditingController addressCtrl = new TextEditingController();
  TextEditingController linkCtrl = new TextEditingController();
  TextEditingController prizeCtrl = new TextEditingController();
  TextEditingController detailsCtrl = new TextEditingController();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      var file = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));

      if (file == null) return;

      file = await compressImage(file.path, 35);

      final imageTemporary = File(file.path);
      setState(() {
        this.image = imageTemporary;
      });
      updateTournamentImage(this.image!.path, widget.tournament!);
    } on PlatformException catch (e) {
      print("Failed to pick image : $e");
    }
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }

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
      String hour = Utility.getTimeFormat(time!.hour);
      String minute = Utility.getTimeFormat(time!.minute);
      if (time == null) {
        //textStartTimeController.text = "Select Time";
      } else {
        if (isStart) {
          textStartTimeController.text = "$hour:$minute";
        } else {
          textEndTimeController.text = "$hour:$minute";
        }
      }
    });
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

  Future<List<Data>> getSports() async {
    APICall apiCall = new APICall();
    List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SportData sportData = await apiCall.getSports();

      if (sportData.data != null) {
        data.addAll(sportData.data!);

        for (var s in data) {
          if (s.id.toString() == widget.tournament.sportId.toString()) {
            this.selectedSport = s;
          }
        }
        setState(() {});
      }
    } else {}
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textStartDateController.text = widget.tournament.startDate;
    textEndDateController.text = widget.tournament.endDate;
    textStartTimeController.text = widget.tournament.startTime;
    textEndTimeController.text = widget.tournament.endTime;

    noOverCtrl.text = widget.tournament.noOfOvers;
    orgNameCtrl.text = widget.tournament.organizerName;
    primNumberCtrl.text = widget.tournament.organizerNumber;
    widget.tournament.secondaryNumber == null ||
            widget.tournament.secondaryNumber == "null"
        ? secNumberCtrl.text = ""
        : secNumberCtrl.text = widget.tournament.secondaryNumber;
    tournamentNameCtrl.text = widget.tournament.tournamentName;
    entryFeesCtrl.text = widget.tournament.entryFees;
    noMemberCtrl.text = widget.tournament.noOfMembers;
    ageCtrl.text = widget.tournament.ageLimit;
    addressCtrl.text = widget.tournament.address;
    widget.tournament.locationLink == null ||
            widget.tournament.locationLink == "null"
        ? secNumberCtrl.text = ""
        : linkCtrl.text = widget.tournament.locationLink;
    widget.tournament.prizeDetails == null ||
            widget.tournament.prizeDetails == "null"
        ? secNumberCtrl.text = ""
        : prizeCtrl.text = widget.tournament.prizeDetails;
    widget.tournament.otherInfo == null || widget.tournament.otherInfo == "null"
        ? secNumberCtrl.text = ""
        : detailsCtrl.text = widget.tournament.otherInfo;
    ballTypeValue = widget.tournament.ballType;
    tournamentCategoryValue = widget.tournament.tournamentCategory;
    textSportController.text = widget.tournament.sportName;
    getSports();
    // this.selectedSport.sportName = widget.tournament.sportName;
    // this.selectedSport.id = widget.tournament.sportId;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Edit Tournament"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            updateTournamentForm(),
          ],
        ),
      ),
    ));
  }

  Widget updateTournamentForm() {
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
                  : widget.tournament.image != null
                      ? Image.network(
                          APIResources.IMAGE_URL + widget.tournament.image,
                          width: 280,
                          height: 150,
                          fit: BoxFit.fill,
                        )
                      : FlutterLogo(size: 100),
            ),
          ),
          isLoading == true
              ? CircularProgressIndicator(
                  color: kBaseColor,
                )
              : GestureDetector(
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
                // Utility.showToast(
                //     "This is selected ${selectedSport.sportName} ${selectedSport.id}");
                isCricket = true;
              } else {
                isCricket = false;
              }
              if (selectedSport.sportName.toString().toLowerCase() ==
                  "box cricket") {
                // Utility.showToast(
                //     "This is selected ${selectedSport.sportName} ${selectedSport.id}");
                isBoxCricket = true;
              } else {
                isBoxCricket = false;
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
          isCricket || isBoxCricket
              ? TextField(
                  controller: noOverCtrl,
                  decoration: InputDecoration(
                      labelText: "Number of Overs",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                )
              : SizedBox(height: 1.0),
          TextField(
            controller: orgNameCtrl,
            decoration: InputDecoration(
                labelText: "Organizer Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: primNumberCtrl,
            decoration: InputDecoration(
                labelText: "Primary Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: secNumberCtrl,
            decoration: InputDecoration(
                labelText: "Secondary Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: tournamentNameCtrl,
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
                    controller: entryFeesCtrl,
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
            controller: noMemberCtrl,
            decoration: InputDecoration(
                labelText: "Number of team members",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: ageCtrl,
            decoration: InputDecoration(
                labelText: "Any Age Requirement",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: addressCtrl,
            decoration: InputDecoration(
                labelText: "Tournament Location (Address)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: linkCtrl,
            decoration: InputDecoration(
                labelText: "Location Link",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
                labelText: "Prize Details",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextFormField(
              controller: prizeCtrl,
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
              )),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
                labelText: "Any Other Information",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextFormField(
              controller: detailsCtrl,
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
              )),
          SizedBox(height: k20Margin),
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                  color: kBaseColor,
                ))
              : RoundedButton(
                  title: "Update Tournament",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: 250,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var playerId = prefs.get("playerId");
                    if (ballTypeValue == null) {
                      ballTypeValue = "";
                    }
                    if (tournamentCategoryValue == null) {
                      tournamentCategoryValue = "";
                    }
                    if (noOverCtrl.text.isEmpty) {
                      noOverCtrl.text = "";
                    }
                    if (linkCtrl.text.isEmpty) {
                      linkCtrl.text = "";
                    }

                    tournament = widget.tournament;
                    tournament!.playerId = playerId!.toString();
                    tournament!.organizerName = orgNameCtrl.text;
                    tournament!.organizerNumber = primNumberCtrl.text;
                    tournament!.secondaryNumber = secNumberCtrl.text;
                    tournament!.tournamentName = tournamentNameCtrl.text;
                    tournament!.startDate = textStartDateController.text;
                    tournament!.endDate = textEndDateController.text;
                    tournament!.entryFees = entryFeesCtrl.text;
                    tournament!.startTime = textStartTimeController.text;
                    tournament!.endTime = textEndTimeController.text;
                    tournament!.noOfMembers = noMemberCtrl.text;
                    tournament!.ageLimit = ageCtrl.text;
                    tournament!.address = addressCtrl.text;
                    tournament!.prizeDetails = prizeCtrl.text;
                    tournament!.otherInfo = detailsCtrl.text;
                    tournament!.playerName = prefs.getString("playerName");
                    tournament!.locationId = prefs.getString("locationId");
                    tournament!.sportId = selectedSport.id.toString();
                    tournament!.sportName = selectedSport.sportName.toString();
                    tournament!.createdAt = Utility.getCurrentDate();
                    tournament!.ballType = ballTypeValue.toString();
                    tournament!.tournamentCategory =
                        tournamentCategoryValue.toString();
                    tournament!.noOfOvers = noOverCtrl.text;
                    tournament!.locationLink = linkCtrl.text;
                    tournament!.status = "1";
                    tournament!.timing = "";
                    updateTournament(tournament!);
                  },
                ),
        ],
      ),
    );
  }

  updateTournament(Tournament tournament) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      TournamentData tournamentData =
          await apiCall.updateTournament(tournament);
      setState(() {
        isLoading = false;
      });
      if (tournamentData == null) {
        print("Tournament null");
      } else {
        if (tournamentData.status!) {
          print("Tournament Success");
          Utility.showToast("Tournament Updated Successfully");
          Navigator.pop(context, true);
        } else {
          print("Tournament Failed");
        }
      }
    }
  }

  updateTournamentImage(String filePath, Tournament tournament) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic status =
          await apiCall.updateTournamentImage(filePath, tournament);
      setState(() {
        isLoading = false;
      });
      if (status == null) {
        print("Tournament null");
      } else {
        if (status!) {
          print("Tournament Success");
          Utility.showToast("Tournament Image Updated Successfully");
          //Navigator.pop(context);
        } else {
          print("Tournament Failed");
        }
      }
    }
  }
}
