import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/venue_data.dart';
import 'package:player/venue/add_venue_slot.dart';
import 'package:player/venue/choose_sport.dart';
import 'package:player/venue/venue_day_slot.dart';
import 'package:player/venue/venue_facilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

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

  // var txtOpenTime = "Open Time";
  // var txtCloseTime = "Close Time";

  Venue? venue;
  var name;
  var description;
  var facilities;
  var address;
  var members;
  var locationLink;
  var city;
  var sport;

  List selectedFacilities = [];
  var selectedSport;

  TextEditingController textFacilityController = new TextEditingController();
  TextEditingController textSportController = new TextEditingController();

  TextEditingController textOpenTimeController = new TextEditingController();
  TextEditingController textCloseTimeController = new TextEditingController();

  bool? isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Utility.showToast("isEditMode ${widget.isEdit}");
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

  Future pickTime(BuildContext context, bool isOpen) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return;

    setState(() {
      openTime = newTime;
      if (openTime != null) {
        int h = openTime!.hour;
        int m = openTime!.minute;
        String hour = Utility.getTimeFormat(h);
        String minute = Utility.getTimeFormat(m);
        if (isOpen) {
          textOpenTimeController.text = "$hour:$minute";
        } else {
          textCloseTimeController.text = "$hour:$minute";
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
            // onChanged: (value) {
            //   sport = value;
            // },
            controller: textSportController,
            readOnly: true,
            onTap: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChooseSport(
                            selectedSport: selectedSport,
                          )));

              // Utility.showToast("This is selected $result");
              selectedSport = result;
              textSportController.text = selectedSport.sportName;
            },
            decoration: InputDecoration(
                labelText: "Which Sport We can Play *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              name = value;
            },
            decoration: InputDecoration(
                labelText: "Venue Name *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          // TextField(
          //   onChanged: (value) {
          //     description = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Venue Description",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
          TextField(
            // onChanged: (value) {
            //   facilities = value;
            // },
            controller: textFacilityController,
            readOnly: true,
            onTap: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VenueFacilities(
                            selectedF: selectedFacilities,
                          )));

              //Utility.showToast("This is selected $result");
              selectedFacilities = result;
              String s = selectedFacilities.join(', ');
              //print(s);
              textFacilityController.text = s;
              // ScaffoldMessenger.of(context)
              //   ..removeCurrentSnackBar()
              //   ..showSnackBar(SnackBar(content: Text('$result')));
            },
            decoration: InputDecoration(
                labelText: "Venue Facilities *",
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
                  controller: textOpenTimeController,
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  onTap: () async {
                    pickTime(context, true);
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Open Time *",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: textCloseTimeController,
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  onTap: () async {
                    pickTime(context, false);
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Close Time *",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
            ],
          )),
          SizedBox(
            height: k20Margin,
          ),
          TextField(
            onChanged: (value) {
              members = value;
            },
            decoration: InputDecoration(
                labelText: "Max Person Allowed (optional)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              address = value;
            },
            decoration: InputDecoration(
                labelText: "Venue Address *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              locationLink = value;
            },
            decoration: InputDecoration(
                labelText: "Location Link (optional)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              city = value;
            },
            decoration: InputDecoration(
                labelText: "Venue City *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            enabled: false,
            decoration: InputDecoration(
                labelText: "Venue Description",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextFormField(
              onChanged: (value) {
                description = value;
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
              )),
          SizedBox(height: k20Margin),
          isLoading == true
              ? CircularProgressIndicator(
                  color: kBaseColor,
                )
              : RoundedButton(
                  title: "NEXT",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: 200,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var playerId = prefs.get("playerId");

                    if (Utility.checkValidation(name.toString())) {
                      Utility.showValidationToast("Please Enter Name");
                      return;
                    }

                    if (Utility.checkValidation(
                        textFacilityController.text.toString())) {
                      Utility.showValidationToast("Please Select Facility");
                      return;
                    }

                    if (selectedSport == null) {
                      Utility.showValidationToast("Please Select Sport");
                      return;
                    }

                    if (Utility.checkValidation(
                        textOpenTimeController.text.toString())) {
                      Utility.showValidationToast("Please Select Open Time");
                      return;
                    }

                    if (Utility.checkValidation(
                        textCloseTimeController.text.toString())) {
                      Utility.showValidationToast("Please Select Close Time");
                      return;
                    }

                    if (Utility.checkValidation(address.toString())) {
                      Utility.showValidationToast("Please Enter Address");
                      return;
                    }

                    if (Utility.checkValidation(city.toString())) {
                      Utility.showValidationToast("Please Enter City");
                      return;
                    }

                    venue = new Venue();

                    venue!.playerId = playerId!.toString();
                    venue!.name = name.toString();
                    venue!.description = description.toString();
                    venue!.facilities = textFacilityController.text;
                    venue!.openTime = textOpenTimeController.text;
                    venue!.closeTime = textCloseTimeController.text;
                    venue!.address = address.toString();
                    venue!.locationLink = locationLink;
                    venue!.locationId = prefs.getString("locationId");
                    venue!.members = members.toString();
                    venue!.city = city.toString();
                    venue!.sport = selectedSport.sportName.toString();
                    venue!.sportId = selectedSport.id.toString();
                    venue!.createdAt = Utility.getCurrentDate();

                    // Utility.showToast("Create Venue");
                    if (this.image != null) {
                      // addVenue(this.image!.path, venue!);
                      // Utility.showToast("File Selected Image");
                      // _onLoading();
                      addVenue();
                    } else {
                      Utility.showToast("Please Select Image");
                      return;
                    }
                    //  print("Create Tournament");
                  },
                ),
        ],
      ),
    );
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
  //   addVenue();
  //   // new Future.delayed(new Duration(seconds: 3), () {
  //   //   Navigator.pop(context); //pop dialog
  //   // });
  // }

  addVenue() async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      VenueData addedVenue = await apiCall.addVenue(this.image!.path, venue!);

      if (addedVenue == null) {
        print("Venue null");
        Utility.showToast("Venue Null");
        setState(() {
          isLoading = false;
        });
      } else {
        if (addedVenue.venue != null) {
          print("Venue Success");
          setState(() {
            isLoading = false;
          });
          // Utility.showToast(
          //     "Venue Created Successfully ${addedVenue.venue!.id} ${addedVenue.venue!.name}");

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VenueDaySlot(
                        venue: addedVenue.venue,
                      )));
        } else {
          setState(() {
            isLoading = false;
          });
          print("Venue Failed");
          Utility.showToast("Venue Failed");
        }
      }
    }
  }
}
