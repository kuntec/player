import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/model/venue_data.dart';
import 'package:player/venue/add_venue_slot.dart';
import 'package:player/venue/choose_sport.dart';
import 'package:player/venue/venue_day_slot.dart';
import 'package:player/venue/venue_facilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class EditVenueDetails extends StatefulWidget {
  dynamic venue;
  EditVenueDetails({required this.venue});

  @override
  _EditVenueDetailsState createState() => _EditVenueDetailsState();
}

class _EditVenueDetailsState extends State<EditVenueDetails> {
  bool? isLoading = false;

  TextEditingController textSportController = new TextEditingController();

  bool isCricket = false;
  bool isBoxCricket = false;

  Venue? venue;

  TimeOfDay? openTime;
  TimeOfDay? closeTime;
  File? image;

  List selectedFacilities = [];
  var selectedSport;

  TextEditingController openTimeController = new TextEditingController();
  TextEditingController closeTimeController = new TextEditingController();

  TextEditingController sportCtrl = new TextEditingController();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController numberCtrl = new TextEditingController();
  TextEditingController descCtrl = new TextEditingController();
  TextEditingController facilityCtrl = new TextEditingController();
  TextEditingController memberCtrl = new TextEditingController();

  TextEditingController addressCtrl = new TextEditingController();
  TextEditingController linkCtrl = new TextEditingController();
  TextEditingController cityCtrl = new TextEditingController();

  Future<List<Data>> getSports() async {
    APICall apiCall = new APICall();
    List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SportData sportData = await apiCall.getSports();

      if (sportData.data != null) {
        data.addAll(sportData.data!);

        for (var s in data) {
          if (s.id.toString() == widget.venue.sportId.toString()) {
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

    openTimeController.text = widget.venue.openTime;
    closeTimeController.text = widget.venue.closeTime;
    //
    sportCtrl.text = widget.venue.sport;
    nameCtrl.text = widget.venue.name;
    widget.venue.description == null
        ? descCtrl.text = ""
        : descCtrl.text = widget.venue.description;
    widget.venue.facilities == null
        ? facilityCtrl.text = ""
        : facilityCtrl.text = widget.venue.facilities;

    widget.venue.members == null
        ? memberCtrl.text = ""
        : memberCtrl.text = widget.venue.members;

    addressCtrl.text = widget.venue.address;
    widget.venue.locationLink == null
        ? linkCtrl.text = ""
        : linkCtrl.text = widget.venue.locationLink;
    cityCtrl.text = widget.venue.city;
    textSportController.text = widget.venue.sport;
    selectedFacilities = facilityCtrl.text.split(", ");
    getSports();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Edit Venue",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            editVenueForm(),
          ],
        ),
      ),
    ));
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
      updateVenueImage(this.image!.path, widget.venue!);
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
          openTimeController.text = "$hour:$minute";
        } else {
          closeTimeController.text = "$hour:$minute";
        }
      }
    });
  }

  Widget editVenueForm() {
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
                  : widget.venue.image != null
                      ? Image.network(
                          APIResources.IMAGE_URL + widget.venue.image,
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
                labelText: "Which Sport We can Play",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: nameCtrl,
            decoration: InputDecoration(
                labelText: "Venue Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: numberCtrl,
            decoration: InputDecoration(
                labelText: "Venue Owner Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          // TextField(
          //   controller: descCtrl,
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
            controller: facilityCtrl,
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
              facilityCtrl.text = s;
              // ScaffoldMessenger.of(context)
              //   ..removeCurrentSnackBar()
              //   ..showSnackBar(SnackBar(content: Text('$result')));
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
                child: TextField(
                  controller: openTimeController,
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  onTap: () async {
                    pickTime(context, true);
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Open Time",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: closeTimeController,
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  onTap: () async {
                    pickTime(context, false);
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Close Time",
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
            controller: memberCtrl,
            decoration: InputDecoration(
                labelText: "Max Person Allowed (optional)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: addressCtrl,
            decoration: InputDecoration(
                labelText: "Venue Address",
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
            controller: cityCtrl,
            decoration: InputDecoration(
                labelText: "Venue City",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextFormField(
              controller: descCtrl,
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
                  title: "UPDATE",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: 200,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var playerId = prefs.get("playerId");

                    if (Utility.checkValidation(nameCtrl.text.toString())) {
                      Utility.showToast("Please Select Name");
                      return;
                    }

                    if (Utility.checkValidation(numberCtrl.text.toString())) {
                      Utility.showToast("Please Select Number");
                      return;
                    }

                    if (Utility.checkValidation(facilityCtrl.text.toString())) {
                      Utility.showToast("Please Select Facility");
                      return;
                    }

                    if (selectedSport == null) {
                      Utility.showToast("Please Select Sport");
                      return;
                    }

                    venue = widget.venue;

                    venue!.playerId = playerId!.toString();
                    venue!.name = nameCtrl.text.toString();
                    venue!.ownerNumber = numberCtrl.text.toString();
                    venue!.description = descCtrl.text.toString();
                    venue!.facilities = facilityCtrl.text.toString();
                    venue!.openTime = openTimeController.text.toString();
                    venue!.closeTime = closeTimeController.text.toString();
                    venue!.address = addressCtrl.text.toString();
                    venue!.locationLink = linkCtrl.text.toString();
                    venue!.locationId = prefs.getString("locationId");
                    venue!.members = memberCtrl.text.toString();
                    venue!.city = cityCtrl.text.toString();
                    venue!.sport = selectedSport.sportName.toString();
                    venue!.sportId = selectedSport.id.toString();
                    venue!.createdAt = Utility.getCurrentDate();

                    updateVenue(venue!);
                  },
                ),
        ],
      ),
    );
  }

  updateVenue(Venue venue) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      VenueData venueData = await apiCall.updateVenue(venue);
      setState(() {
        isLoading = false;
      });
      if (venueData == null) {
        print("Venue null");
      } else {
        if (venueData.status!) {
          print("Venue Success");
          Utility.showToast("Venue Updated Successfully");
          Navigator.pop(context, true);
        } else {
          print("Venue Failed");
        }
      }
    }
  }

  updateVenueImage(String filePath, Venue venue) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic status = await apiCall.updateVenueImage(filePath, venue);
      setState(() {
        isLoading = false;
      });
      if (status == null) {
        print("Venue null");
      } else {
        if (status!) {
          print("Venue Success");
          Utility.showToast("Venue Image Updated Successfully");
          //Navigator.pop(context);
        } else {
          print("Venue Failed");
        }
      }
    }
  }
}
