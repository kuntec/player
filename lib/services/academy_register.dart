import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcademyRegister extends StatefulWidget {
  const AcademyRegister({Key? key}) : super(key: key);

  @override
  _AcademyRegisterState createState() => _AcademyRegisterState();
}

class _AcademyRegisterState extends State<AcademyRegister> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text("Academy Register"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              addServiceForm(),
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

  Widget addServiceForm() {
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
              //name = value;
            },
            decoration: InputDecoration(
                labelText: "Academy Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              //description = value;
            },
            decoration: InputDecoration(
                labelText: "Address",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),

          TextField(
            onChanged: (value) {
              //facilities = value;
            },
            decoration: InputDecoration(
                labelText: "City",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),

          TextField(
            onChanged: (value) {
              //facilities = value;
            },
            decoration: InputDecoration(
                labelText: "Location Link",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),

          TextField(
            onChanged: (value) {
              //facilities = value;
            },
            decoration: InputDecoration(
                labelText: "Contact Person Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),

          TextField(
            onChanged: (value) {
              //facilities = value;
            },
            decoration: InputDecoration(
                labelText: "Contact Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              //facilities = value;
            },
            decoration: InputDecoration(
                labelText: "About Academy",
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
                    //pickTime(context, true);
                  },
                  child: Text(
                    "",
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
                    // pickTime(context, false);
                  },
                  child: Text(
                    "",
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
              //address = value;
            },
            decoration: InputDecoration(
                labelText: "Venue Location",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              // locationLink = value;
            },
            decoration: InputDecoration(
                labelText: "Location Link",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              //city = value;
            },
            decoration: InputDecoration(
                labelText: "Venue City",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              //sport = value;
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
            title: "ADD",
            color: kBaseColor,
            txtColor: Colors.white,
            minWidth: 150,
            onPressed: () async {
//              if (widget.isEdit) {}
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var playerId = prefs.get("playerId");
              // venue = new Venue();
              //
              // venue!.playerId = playerId!.toString();
              // venue!.name = name.toString();
              // venue!.description = description.toString();
              // venue!.facilities = facilities.toString();
              // venue!.openTime = txtOpenTime;
              // venue!.closeTime = txtCloseTime;
              // venue!.address = address.toString();
              // venue!.locationLink = locationLink;
              // venue!.locationId = "1";
              // venue!.city = city.toString();
              // venue!.sport = sport.toString();
              // venue!.createdAt = Utility.getCurrentDate();

              // Utility.showToast("Create Venue");
              if (this.image != null) {
                // addVenue(this.image!.path, venue!);
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

  // addService(String filePath, Venue venue) async {
  //   APICall apiCall = new APICall();
  //   bool connectivityStatus = await Utility.checkConnectivity();
  //   if (connectivityStatus) {
  //     dynamic addedVenue = await apiCall.addVenue(filePath, venue);
  //
  //     if (addedVenue == null) {
  //       print("Venue null");
  //       Utility.showToast("Venue Null");
  //     } else {
  //       if (addedVenue['id'] != null) {
  //         print("Venue Success");
  //         Utility.showToast(
  //             "Venue Created Successfully ${addedVenue['id']} ${addedVenue['name']}");
  //         Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => AddVenueSlot(
  //                       venue: addedVenue,
  //                     )));
  //       } else {
  //         print("Venue Failed");
  //         Utility.showToast("Venue Failed");
  //       }
  //     }
  //   }
  // }
}
