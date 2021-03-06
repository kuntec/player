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
import 'package:player/model/event_data.dart';
import 'package:player/model/tournament_data.dart';
import 'package:player/screens/tournament_participants.dart';
import 'package:player/venue/choose_sport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class EditEvent extends StatefulWidget {
  dynamic event;
  EditEvent({this.event});

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? time;

  Event? event;

  TextEditingController eventNameController = new TextEditingController();
  TextEditingController eventTypeController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController entryFeesController = new TextEditingController();
  TextEditingController noOfMembersController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController locationLinkController = new TextEditingController();
  TextEditingController otherInfoController = new TextEditingController();
  TextEditingController organizerNameController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController secondaryNumberController = new TextEditingController();

  TextEditingController textStartDateController = new TextEditingController();
  TextEditingController textEndDateController = new TextEditingController();
  TextEditingController textStartTimeController = new TextEditingController();
  TextEditingController textEndTimeController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initForm();
  }

  initForm() {
    eventNameController.text = widget.event.name;
    eventTypeController.text = widget.event.type;

    widget.event.description == null || widget.event.description == "null"
        ? descriptionController.text = ""
        : descriptionController.text = widget.event.description;
//    descriptionController.text = widget.event.description;

    entryFeesController.text = widget.event.entryFees;
    textStartDateController.text = widget.event.startDate;
    textEndDateController.text = widget.event.endDate;
    textStartTimeController.text = widget.event.startTime;
    textEndTimeController.text = widget.event.endTime;
    noOfMembersController.text = widget.event.members;
    addressController.text = widget.event.address;

    //locationLinkController.text = widget.event.locationLink;
    widget.event.locationLink == null || widget.event.locationLink == "null"
        ? locationLinkController.text = ""
        : locationLinkController.text = widget.event.locationLink;

    //otherInfoController.text = widget.event.details;
    widget.event.details == null || widget.event.details == "null"
        ? otherInfoController.text = ""
        : otherInfoController.text = widget.event.details;

    organizerNameController.text = widget.event.organizerName;
    numberController.text = widget.event.number;

    widget.event.secondaryNumber == null ||
            widget.event.secondaryNumber == "null"
        ? secondaryNumberController.text = ""
        : secondaryNumberController.text = widget.event.secondaryNumber;

//    secondaryNumberController.text = widget.event.secondaryNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Edit Event",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [addEventForm()],
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
      updateEventImage(this.image!.path, widget.event);
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
                      width: 280,
                      height: 150,
                      fit: BoxFit.fill,
                    )
                  : widget.event.image != null
                      ? Image.network(
                          APIResources.IMAGE_URL + widget.event.image,
                          width: 280,
                          height: 150,
                          fit: BoxFit.fill,
                        )
                      : FlutterLogo(size: 100),
            ),
          ),
          isLoading == true
              ? CircularProgressIndicator()
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
            controller: numberController,
            decoration: InputDecoration(
                labelText: "Primary Number *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
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
                  title: "Update Event",
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

                    event = widget.event;
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
                    event!.startDate = textStartDateController.text.toString();
                    event!.endDate = textEndDateController.text.toString();
                    event!.startTime = textStartTimeController.text.toString();
                    event!.endTime = textEndTimeController.text.toString();
                    event!.details = otherInfoController.text.toString();

                    event!.organizerName =
                        organizerNameController.text.toString();
                    event!.number = numberController.text.toString();
                    event!.secondaryNumber =
                        secondaryNumberController.text.toString();

                    event!.createdAt = Utility.getCurrentDate();
                    updateEvent(event!);
                    // if (this.image != null) {
                    //   //updateEvent(this.image!.path, event!);
                    //   //Utility.showToast("File Selected Image");
                    // } else {
                    //   Utility.showToast("Please Select Image");
                    // }
                  },
                ),
        ],
      ),
    );
  }

  bool? isLoading = false;
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
          Utility.showToast("Event Updated Successfully");
          Navigator.pop(context, true);
        } else {
          print("Event Failed");
        }
      }
    }
  }

  updateEventImage(String filePath, Event event) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic status = await apiCall.updateEventImage(filePath, event);
      setState(() {
        isLoading = false;
      });
      if (status == null) {
        print("Event null");
      } else {
        if (status!) {
          print("Event Success");
          Utility.showToast("Event Image Updated Successfully");
          //Navigator.pop(context);
        } else {
          print("Event Failed");
        }
      }
    }
  }
}
