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

class PhysioFitnessRegister extends StatefulWidget {
  dynamic serviceId;

  PhysioFitnessRegister({this.serviceId});

  @override
  _PhysioFitnessRegisterState createState() => _PhysioFitnessRegisterState();
}

class _PhysioFitnessRegisterState extends State<PhysioFitnessRegister> {
  File? image;
  Service? service;
  bool? isLoading = false;

  var name;
  var address;
  var city;
  var contactNo;
  var secondaryNo;
  var experience;
  var details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Physio Fitness Register"),
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
              name = value;
            },
            decoration: InputDecoration(
                labelText: "Name",
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
            onChanged: (value) {
              experience = value;
            },
            decoration: InputDecoration(
                labelText: "Experience",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            enabled: false,
            decoration: InputDecoration(
                labelText: "More Details",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextFormField(
              onChanged: (value) {
                details = value;
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
              ? CircularProgressIndicator(color: kBaseColor)
              : RoundedButton(
                  title: "ADD",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: 150,
                  onPressed: () async {
//              if (widget.isEdit) {}
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var playerId = prefs.get("playerId");
                    service = new Service();

                    service!.playerId = playerId!.toString();
                    service!.serviceId = widget.serviceId.toString();
                    service!.name = name.toString();
                    service!.address = address.toString();
                    service!.city = city.toString();
                    service!.contactName = "";
                    service!.contactNo = contactNo.toString();
                    service!.secondaryNo = secondaryNo.toString();
                    service!.about = details.toString();
                    service!.locationLink = "";
                    service!.monthlyFees = "";
                    service!.coaches = "";
                    service!.feesPerMatch = "";
                    service!.feesPerDay = "";
                    service!.experience = experience.toString();
                    service!.sportName = "";
                    service!.sportId = "";
                    service!.companyName = name.toString();

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
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic id = await apiCall.addServiceData(filePath, service);
      setState(() {
        isLoading = false;
      });
      if (id == null) {
        print("null");
        Utility.showToast("Failed");
      } else {
        Utility.showToast("Service Created Successfully");
        Navigator.pop(context);
      }
    }
  }
}
