import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_model.dart';
import 'package:player/model/service_photo.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/services/service_photos.dart';
import 'package:player/venue/venue_facilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcademyRegister extends StatefulWidget {
  dynamic serviceId;
  AcademyRegister({this.serviceId});

  @override
  _AcademyRegisterState createState() => _AcademyRegisterState();
}

class _AcademyRegisterState extends State<AcademyRegister> {
  File? image;
  Data? selectedSport;
  List<Data>? sports;
  Service? service;

  var academyName;
  var address;
  var addressLink;
  var city;
  var ownerName;
  var contactNumber;
  var secondaryNumber;
  var monthlyFees;
  var coaches;
  var about;

  List selectedFacilities = [];
  TextEditingController textFacilityController = new TextEditingController();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSports();
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
          SizedBox(height: kMargin),
          sports != null
              ? buildSportData(sports!)
              : Container(child: Text("Loading...")),
          SizedBox(height: kMargin),
          TextField(
            onChanged: (value) {
              academyName = value;
            },
            decoration: InputDecoration(
                labelText: "Academy Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
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
              ownerName = value;
            },
            decoration: InputDecoration(
                labelText: "Owner Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              contactNumber = value;
            },
            decoration: InputDecoration(
                labelText: "Contact Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              secondaryNumber = value;
            },
            decoration: InputDecoration(
                labelText: "Secondary Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: textFacilityController,
            readOnly: true,
            onTap: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VenueFacilities(
                            selectedF: selectedFacilities,
                          )));
              selectedFacilities = result;
              String s = selectedFacilities.join(', ');
              textFacilityController.text = s;
            },
            decoration: InputDecoration(
                labelText: "Facilities",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              monthlyFees = value;
            },
            decoration: InputDecoration(
                labelText: "Monthly Fees",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              coaches = value;
            },
            decoration: InputDecoration(
                labelText: "Coaches",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "About Academy",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextFormField(
              onChanged: (value) {
                about = value;
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
          RoundedButton(
            title: "ADD",
            color: kBaseColor,
            txtColor: Colors.white,
            minWidth: 150,
            onPressed: () async {
              if (selectedSport == null) {
                Utility.showToast("Please Select Sport");
                return;
              } else {
                Utility.showToast(
                    "Selected Sport ${selectedSport!.sportName} - ${selectedSport!.id}");
              }
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var playerId = prefs.get("playerId");
              service = new Service();

              service!.playerId = playerId!.toString();
              service!.serviceId = widget.serviceId.toString();
              service!.name = academyName.toString();
              service!.address = address.toString();
              service!.city = city.toString();
              service!.contactName = ownerName.toString();
              service!.contactNo = contactNumber.toString();
              service!.secondaryNo = secondaryNumber.toString();
              service!.about = about.toString();
              service!.locationLink = addressLink.toString();
              service!.monthlyFees = monthlyFees.toString();
              service!.coaches = coaches.toString();
              service!.feesPerMatch = "";
              service!.feesPerDay = "";
              service!.experience = "";
              service!.sportName = selectedSport!.sportName;
              service!.sportId = selectedSport!.id.toString();
              service!.companyName = "";

              if (this.image != null) {
                addService(this.image!.path, service!);
                // Utility.showToast("File Selected Image");
              } else {
                Utility.showToast("Please Select Image");
              }
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
        if (id > 0) {
          print("Success");
          Utility.showToast("Service Created Successfully");
          // Navigator.pop(context);
          var result = Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServicePhotos(serviceDataId: id)));
          if (result == true) {
            Utility.showToast("Result $result");
          }
        } else {
          print("Failed");
          Utility.showToast("Failed");
        }
      }
    }
  }
}
