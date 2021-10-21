import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrophySellerRegister extends StatefulWidget {
  dynamic serviceId;

  TrophySellerRegister({this.serviceId});

  @override
  _TrophySellerRegisterState createState() => _TrophySellerRegisterState();
}

class _TrophySellerRegisterState extends State<TrophySellerRegister> {
  File? image;
  Service? service;

  var companyName;
  var address;
  var city;
  var addressLink;
  var ownerName;
  var contactNo;
  var secondaryNo;
  var details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Trophy Seller Register"),
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
                      width: 150,
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
            keyboardType: TextInputType.text,
            onChanged: (value) {
              companyName = value;
            },
            decoration: InputDecoration(
                labelText: "Company Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              address = value;
            },
            decoration: InputDecoration(
                labelText: "Address",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              city = value;
            },
            decoration: InputDecoration(
                labelText: "City",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              addressLink = value;
            },
            decoration: InputDecoration(
                labelText: "Address Link",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              ownerName = value;
            },
            decoration: InputDecoration(
                labelText: "Owner Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              contactNo = value;
            },
            decoration: InputDecoration(
                labelText: "Contact Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              secondaryNo = value;
            },
            decoration: InputDecoration(
                labelText: "Secondary Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              details = value;
            },
            decoration: InputDecoration(
                labelText: "More Details",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
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
              service = new Service();

              service!.playerId = playerId!.toString();
              service!.serviceId = widget.serviceId.toString();
              service!.name = companyName.toString();
              service!.address = address.toString();
              service!.city = city.toString();
              service!.contactName = ownerName.toString();
              service!.contactNo = contactNo.toString();
              service!.secondaryNo = secondaryNo.toString();
              service!.about = details.toString();
              service!.locationLink = addressLink.toString();
              service!.monthlyFees = "";
              service!.coaches = "";
              service!.feesPerMatch = "";
              service!.feesPerDay = "";
              service!.experience = "";
              service!.sportName = "";
              service!.sportId = "";
              service!.companyName = companyName.toString();

              if (this.image != null) {
                addService(this.image!.path, service!);
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

  addService(String filePath, Service service) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic status = await apiCall.addServiceData(filePath, service);

      if (status == null) {
        print("null");
        Utility.showToast("Failed");
      } else {
        if (status) {
          print("Success");
          Utility.showToast("Service Created Successfully");
          Navigator.pop(context);
        } else {
          print("Failed");
          Utility.showToast("Failed");
        }
      }
    }
  }
}
