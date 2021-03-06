import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:player/event/edit_event.dart';
import 'package:player/model/event_data.dart';
import 'package:player/model/tournament_data.dart';
import 'package:player/screens/tournament_participants.dart';
import 'package:player/venue/choose_sport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class EventRegister extends StatefulWidget {
  const EventRegister({Key? key}) : super(key: key);

  @override
  _EventRegisterState createState() => _EventRegisterState();
}

class _EventRegisterState extends State<EventRegister> {
  bool? isMyEventSelected = false;
  bool? isLoading = false;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? time;

  Event? event;

  // var organizerName;
  // var number;
  // var secondaryNumber;
  //
  // var eventName;
  // var eventType;
  // var description;
  // var entryFees;
  // var noOfMembers;
  // var address;
  // var locationLink;
  // var otherInfo;

  TextEditingController organizerNameController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController secondaryNumberController = new TextEditingController();
  TextEditingController eventNameController = new TextEditingController();
  TextEditingController eventTypeController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController entryFeesController = new TextEditingController();
  TextEditingController noOfMembersController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController locationLinkController = new TextEditingController();
  TextEditingController otherInfoController = new TextEditingController();

  TextEditingController textStartDateController = new TextEditingController();
  TextEditingController textEndDateController = new TextEditingController();
  TextEditingController textStartTimeController = new TextEditingController();
  TextEditingController textEndTimeController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Register Event",
          style: TextStyle(color: Colors.black),
        ),
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
                          isMyEventSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabLeftDecoration.copyWith(
                            color:
                                isMyEventSelected! ? Colors.white : kBaseColor),
                        child: Center(
                          child: Text(
                            "Create New Event",
                            style: TextStyle(
                                color: isMyEventSelected!
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
                          isMyEventSelected = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabRightDecoration.copyWith(
                            color:
                                isMyEventSelected! ? kBaseColor : Colors.white),
                        child: Center(
                          child: Text(
                            "My Event",
                            style: TextStyle(
                                color: isMyEventSelected!
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
            isMyEventSelected! ? myEvent() : addEventForm()
          ],
        ),
      ),
    );
  }

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

  File? image;

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

  Widget addEventForm() {
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
                      width: 180,
                      height: 180,
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
            controller: eventNameController,
            decoration: InputDecoration(
                labelText: "Event Name *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: eventTypeController,
            decoration: InputDecoration(
                labelText: "Event Type *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
                labelText: "Description",
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
                      labelText: "Start Date *",
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
                    pickDate(context, false);
                  },
                  controller: textEndDateController,
                  decoration: InputDecoration(
                      labelText: "End Date *",
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
                    controller: entryFeesController,
                    decoration: InputDecoration(
                        labelText: "Entry Fees *",
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
                        labelText: "Start Time *",
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
                        labelText: "End Time *",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
              ],
            ),
          ),
          TextField(
            controller: noOfMembersController,
            decoration: InputDecoration(
                labelText: "members allowed per entry fee *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
                labelText: "Location (Address) *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: locationLinkController,
            decoration: InputDecoration(
                labelText: "Location Link (optional)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: organizerNameController,
            decoration: InputDecoration(
                labelText: "Organizer Name *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: numberController,
            decoration: InputDecoration(
                labelText: "Primary Number *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: secondaryNumberController,
            decoration: InputDecoration(
                labelText: "Secondary Number (optional)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            enabled: false,
            decoration: InputDecoration(
                labelText: "Other Information (optional)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextFormField(
              controller: otherInfoController,
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
              ? CircularProgressIndicator(
                  color: kBaseColor,
                )
              : RoundedButton(
                  title: "Create Event",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: 250,
                  onPressed: () async {
                    if (Utility.checkValidation(
                        eventNameController.text.toString())) {
                      Utility.showValidationToast("Please Enter Event Name");
                      return;
                    }
                    if (Utility.checkValidation(
                        eventTypeController.text.toString())) {
                      Utility.showValidationToast("Please Enter Event Type");
                      return;
                    }

                    if (Utility.checkValidation(
                        addressController.text.toString())) {
                      Utility.showValidationToast("Please Enter Address");
                      return;
                    }

                    if (Utility.checkValidation(
                        entryFeesController.text.toString())) {
                      Utility.showValidationToast("Please Enter Entry Fees");
                      return;
                    }

                    if (Utility.checkValidation(
                        noOfMembersController.text.toString())) {
                      Utility.showValidationToast("Please Enter No of Members");
                      return;
                    }

                    if (Utility.checkValidation(
                        organizerNameController.text.toString())) {
                      Utility.showValidationToast(
                          "Please Enter Organizer Name");
                      return;
                    }

                    if (Utility.checkValidation(
                        numberController.text.toString())) {
                      Utility.showValidationToast("Please Enter Number");
                      return;
                    }

                    if (Utility.checkValidation(
                        textStartDateController.text.toString())) {
                      Utility.showValidationToast("Please Enter Start Date");
                      return;
                    }

                    if (Utility.checkValidation(
                        textEndDateController.text.toString())) {
                      Utility.showValidationToast("Please Enter End Date");
                      return;
                    }

                    if (Utility.checkValidation(
                        textStartTimeController.text.toString())) {
                      Utility.showValidationToast("Please Enter Start Time");
                      return;
                    }

                    if (Utility.checkValidation(
                        textEndTimeController.text.toString())) {
                      Utility.showValidationToast("Please Enter End Time");
                      return;
                    }

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var playerId = prefs.get("playerId");
                    // if (locationLink == null) locationLink = "";

                    event = new Event();
                    event!.playerId = playerId!.toString();
                    event!.name = eventNameController.text.toString();
                    event!.type = eventTypeController.text.toString();
                    event!.description = descriptionController.text.toString();
                    event!.address = addressController.text.toString();
                    event!.locationLink =
                        locationLinkController.text.toString();
                    event!.locationId = prefs.get("locationId").toString();
                    event!.entryFees = entryFeesController.text.toString();
                    event!.members = noOfMembersController.text.toString();
                    event!.startDate = textStartDateController.text;
                    event!.endDate = textEndDateController.text;
                    event!.startTime = textStartTimeController.text;
                    event!.endTime = textEndTimeController.text;
                    event!.details = otherInfoController.text.toString();

                    event!.organizerName =
                        organizerNameController.text.toString();
                    event!.number = numberController.text.toString();
                    event!.secondaryNumber =
                        secondaryNumberController.text.toString();
                    event!.status = "1";

                    event!.createdAt = Utility.getCurrentDate();
                    if (this.image != null) {
                      addEvent(this.image!.path, event!);
                      //Utility.showToast("File Selected Image");
                    } else {
                      Utility.showToast("Please Select Image");
                    }
                  },
                ),
        ],
      ),
    );
  }

  addEvent(String filePath, Event event) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic status = await apiCall.addEvent(filePath, event);
      setState(() {
        isLoading = false;
      });
      if (status == null) {
        print("Event null");
      } else {
        if (status!) {
          print("Event Success");
          Utility.showToast("Event Created Successfully");
          Navigator.pop(context);
        } else {
          print("Event Failed");
        }
      }
    }
  }

  // Widget myEventList() {
  //   return Container(
  //     child: events != null
  //         ? ListView.builder(
  //             padding: EdgeInsets.only(bottom: 110),
  //             scrollDirection: Axis.vertical,
  //             shrinkWrap: true,
  //             itemCount: events!.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return eventItem(events![index]);
  //             },
  //           )
  //         : Text("Loading"),
  //   );
  // }

  Widget myEvent() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(5.0),
      child: FutureBuilder(
        future: getMyEvents(),
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
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Events'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 110),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return eventItem(snapshot.data[index]);
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
    );
  }

  List<Event>? events;

  Future<List<Event>?> getMyEvents() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      EventData eventData = await apiCall.getMyEvent(playerId.toString());
      if (eventData.events != null) {
        events = eventData.events!;
        events = events!.reversed.toList();
        //setState(() {});
      }

      if (eventData.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(eventData.message!);
      }
    }
    return events;
  }
  //
  // void _showDialog(dynamic event) async {
  //   return await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Expanded(
  //                   flex: 1,
  //                   child: CustomButton(
  //                       height: 20,
  //                       fontSize: 16.0,
  //                       title: "Edit",
  //                       color: kBaseColor,
  //                       txtColor: Colors.white,
  //                       minWidth: 80,
  //                       onPressed: () async {
  //                         _dismissDialog();
  //                         var result = await Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (context) => EditEvent(
  //                                       event: event,
  //                                     )));
  //                         if (result == true) {
  //                           _refresh();
  //                         }
  //                       }),
  //                 ),
  //                 SizedBox(width: 20),
  //                 Expanded(
  //                   flex: 1,
  //                   child: CustomButton(
  //                       height: 20,
  //                       fontSize: 16.0,
  //                       title: "Delete",
  //                       color: Colors.red,
  //                       txtColor: Colors.white,
  //                       minWidth: 80,
  //                       onPressed: () async {
  //                         _dismissDialog();
  //                       }),
  //                 ),
  //               ],
  //             );
  //           },
  //         ),
  //         // actions: <Widget>[
  //         //   TextButton(
  //         //       onPressed: () {
  //         //         _dismissDialog();
  //         //       },
  //         //       child: Text('Close')),
  //         // ],
  //       );
  //     },
  //   );
  // }
  //
  // _dismissDialog() {
  //   Navigator.pop(context);
  // }

  _refresh() {
    setState(() {});
  }

  var selectedEvent;
  Widget eventItem(dynamic event) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TournamentParticipants(event: event, type: "1")));
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
//      padding: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
        // height: 200,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                selectedEvent = event;
                showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: createDialog,
                );
              },
              child: Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.more_horiz,
                  size: 20,
                  color: kBaseColor,
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    height: 80.0,
                    width: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        APIResources.IMAGE_URL + event.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Row(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 100.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text(
                    event.name,
                    style: TextStyle(
                        color: kBaseColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    event.address,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Start Date: ${event.startDate}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Location: ${event.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    event.status == "1" ? "Booking: ON" : "Booking: OFF",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: kServiceBoxItem.copyWith(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
                        child: Text(
                          "\u{20B9} ${event.entryFees}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
        title: Text("Choose an option"),
        // content: Text("Message"),
        actions: [
          CupertinoDialogAction(
            child: Text(
              "Edit",
              style: TextStyle(color: kBaseColor),
            ),
            onPressed: () async {
              Navigator.pop(context);

              var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditEvent(
                            event: selectedEvent,
                          )));
              if (result == true) {
                _refresh();
              }
            },
          ),
          CupertinoDialogAction(
            child: Text(
              selectedEvent.status == "1" ? "Stop Booking" : "Restart Booking",
              style: TextStyle(color: kBaseColor),
            ),
            onPressed: () async {
              Navigator.pop(context);
              selectedEvent.status == "1"
                  ? selectedEvent.status = "0"
                  : selectedEvent.status = "1";
              await updateEvent(selectedEvent);
            },
          ),
          CupertinoDialogAction(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              Navigator.pop(context);
              await deleteEvent(selectedEvent.id.toString());
            },
          ),
          CupertinoDialogAction(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );

  updateEvent(Event event) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      EventData eventData = await apiCall.updateEvent(event);
      setState(() {
        isLoading = false;
      });
      if (eventData == null) {
        print("Event null");
      } else {
        if (eventData.status!) {
          print("Event Success");
          Utility.showToast("Event Booking Status Updated");
          // Navigator.pop(context, true);
        } else {
          print("Event Failed");
        }
      }
    }
  }

  deleteEvent(String id) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      EventData eventData = await apiCall.deleteEvent(id);
      if (eventData.status!) {
        Utility.showToast(eventData.message.toString());
        _refresh();
      } else {
        print(eventData.message!);
      }
    }
  }
}
