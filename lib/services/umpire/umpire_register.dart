import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_model.dart';
import 'package:player/model/sport_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UmpireRegister extends StatefulWidget {
  dynamic serviceId;
  UmpireRegister({required this.serviceId});

  @override
  _UmpireRegisterState createState() => _UmpireRegisterState();
}

class _UmpireRegisterState extends State<UmpireRegister> {
  File? image;
  Service? service;

  var name;
  var contact_no;
  var secondaryNo;
  var city;
  var fees_per_match;
  var fees_per_day;
  var experience;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSports();
  }

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
        title: Text("Umpire Register"),
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
          SizedBox(height: k20Margin),
          sports != null
              ? buildSportData(sports!)
              : Container(child: Text("Loading...")),
          TextField(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              name = value;
            },
            decoration: InputDecoration(
                labelText: "Umpire Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              contact_no = value;
            },
            decoration: InputDecoration(
                labelText: "Umpire Number",
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
                labelText: "Umpire Number",
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
              fees_per_match = value;
            },
            decoration: InputDecoration(
                labelText: "Fees per match",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              fees_per_day = value;
            },
            decoration: InputDecoration(
                labelText: "Fees Per Day",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              experience = value;
            },
            decoration: InputDecoration(
                labelText: "Umpiring Experience",
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
              service!.name = name.toString();
              service!.address = "";
              service!.city = city.toString();
              service!.contactName = "";
              service!.contactNo = contact_no.toString();
              service!.secondaryNo = "";
              service!.about = "";
              service!.locationLink = "";
              service!.monthlyFees = "";
              service!.coaches = "";
              service!.feesPerMatch = fees_per_match.toString();
              service!.feesPerDay = fees_per_day.toString();
              service!.experience = experience.toString();
              service!.sportName = selectedSport!.sportName;
              service!.sportId = selectedSport!.id.toString();
              service!.companyName = "";

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
      dynamic id = await apiCall.addServiceData(filePath, service);

      if (id == null) {
        print("null");
        Utility.showToast("Failed");
      } else {
        print("Success");
        Utility.showToast("Umpire Created Successfully");
        Navigator.pop(context);
      }
    }
  }

  List<Data>? sports;
  Data? selectedSport;
  Future<List<Data>> getSports() async {
    APICall apiCall = new APICall();
    List<Data> list = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SportData sportData = await apiCall.getSports();
      if (sportData.data != null) {
        list = sportData.data!;
        setState(() {
          sports = list;
//          this.selectedSport = list[0];
        });
      }
    }
    return list;
  }

  Widget buildSportData(List<Data> data) {
    return DropdownButton<Data>(
      value: selectedSport != null ? selectedSport : null,
      hint: Text("Select Sport"),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: kBaseColor,
      ),
      onChanged: (Data? newValue) {
        // this._selectedLK = newValue!;
        setState(() {
          this.selectedSport = newValue!;
        });
      },
      items: data.map<DropdownMenuItem<Data>>((Data value) {
        return DropdownMenuItem<Data>(
          value: value,
          child: Text(value.sportName!),
        );
      }).toList(),
    );
  }
}
