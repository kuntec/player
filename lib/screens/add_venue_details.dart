import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/venue_data.dart';
import 'package:player/screens/add_venue_slot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddVenueDetails extends StatefulWidget {
  dynamic venueItem;
  dynamic isEdit;
  AddVenueDetails({this.venueItem, this.isEdit});

  @override
  _AddVenueDetailsState createState() => _AddVenueDetailsState();
}

class _AddVenueDetailsState extends State<AddVenueDetails> {
  File? image;
  TimeOfDay? openTime;
  TimeOfDay? closeTime;

  var txtOpenTime = "Open Time";
  var txtCloseTime = "Close Time";

  Venue? venue;
  var name;
  var description;
  var facilities;
  var address;
  var locationLink;
  var city;
  var sport;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utility.showToast("isEditMode ${widget.isEdit}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Venue")),
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
        child: Container(
          margin: EdgeInsets.all(kMargin),
          child: Column(
            children: [
              addVenueForm(),
            ],
          ),
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

  Future pickTime(BuildContext context, bool isOpen) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return;

    if (newTime == null) return;
    setState(() {
      openTime = newTime;
      if (openTime != null) {
        if (isOpen) {
          if (openTime!.hour < 10) {
            var hour = "0" + openTime!.hour.toString();
            if (openTime!.minute < 10) {
              var minute = "0" + openTime!.minute.toString();
              txtOpenTime = "$hour:$minute";
            }
          }
          txtOpenTime = "${openTime!.hour}:${openTime!.minute}";
        } else {
          txtCloseTime = "${openTime!.hour}:${openTime!.minute}";
        }
      }
    });
  }

  Widget addVenueForm() {
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
              name = value;
            },
            decoration: InputDecoration(
                labelText: "Venue Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              description = value;
            },
            decoration: InputDecoration(
                labelText: "Venue Description",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),

          TextField(
            onChanged: (value) {
              facilities = value;
            },
            decoration: InputDecoration(
                labelText: "Venue Facilities",
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
                child: GestureDetector(
                  onTap: () {
                    pickTime(context, true);
                  },
                  child: Text(
                    txtOpenTime,
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    pickTime(context, false);
                  },
                  child: Text(
                    txtCloseTime,
                  ),
                ),
              ),
            ],
          )),
          SizedBox(
            height: k20Margin,
          ),
          TextField(
            onChanged: (value) {
              address = value;
            },
            decoration: InputDecoration(
                labelText: "Venue Location",
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
              city = value;
            },
            decoration: InputDecoration(
                labelText: "Venue City",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              sport = value;
            },
            decoration: InputDecoration(
                labelText: "Which Sport We can Play",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          // TextField(
          //   onChanged: (value) {
          //     prizeDetails = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Prize Details",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
          // TextField(
          //   onChanged: (value) {
          //     otherInfo = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Any Other Information",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
          SizedBox(height: k20Margin),
          RoundedButton(
            title: widget.isEdit ? "UPDATE" : "NEXT",
            color: kBaseColor,
            txtColor: Colors.white,
            minWidth: 150,
            onPressed: () async {
//              if (widget.isEdit) {}
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var playerId = prefs.get("playerId");
              venue = new Venue();

              venue!.playerId = playerId!.toString();
              venue!.name = name.toString();
              venue!.description = description.toString();
              venue!.facilities = facilities.toString();
              venue!.openTime = txtOpenTime;
              venue!.closeTime = txtCloseTime;
              venue!.address = address.toString();
              venue!.locationLink = locationLink;
              venue!.locationId = "1";
              venue!.city = city.toString();
              venue!.sport = sport.toString();
              venue!.createdAt = Utility.getCurrentDate();

              // Utility.showToast("Create Venue");
              if (this.image != null) {
                addVenue(this.image!.path, venue!);
                // Utility.showToast("File Selected Image");
              } else {
                Utility.showToast("Please Select Image");
              }
              //  print("Create Tournament");
            },
          ),
        ],
      ),
    );
  }

  addVenue(String filePath, Venue venue) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic addedVenue = await apiCall.addVenue(filePath, venue);

      if (addedVenue == null) {
        print("Venue null");
        Utility.showToast("Venue Null");
      } else {
        if (addedVenue['id'] != null) {
          print("Venue Success");
          Utility.showToast(
              "Venue Created Successfully ${addedVenue['id']} ${addedVenue['name']}");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AddVenueSlot(
                        venue: addedVenue,
                      )));
        } else {
          print("Venue Failed");
          Utility.showToast("Venue Failed");
        }
      }
    }
  }
}
