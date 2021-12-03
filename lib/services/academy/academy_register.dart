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
  bool? isLoading = false;

  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController addressCtrl = new TextEditingController();
  TextEditingController addressLinkCtrl = new TextEditingController();
  TextEditingController cityCtrl = new TextEditingController();
  TextEditingController ownerNameCtrl = new TextEditingController();
  TextEditingController contactCtrl = new TextEditingController();
  TextEditingController secondaryCtrl = new TextEditingController();
  TextEditingController monthlyFeesCtrl = new TextEditingController();
  TextEditingController coachesCtrl = new TextEditingController();
  TextEditingController textFacilityController = new TextEditingController();
  TextEditingController detailsCtrl = new TextEditingController();

  List selectedFacilities = [];

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
          SizedBox(height: kMargin),
          sports != null
              ? buildSportData(sports!)
              : Container(child: Text("Loading...")),
          SizedBox(height: kMargin),
          TextField(
            controller: nameCtrl,
            decoration: InputDecoration(
                labelText: "Academy Name *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: addressCtrl,
            decoration: InputDecoration(
                labelText: "Address *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: addressLinkCtrl,
            decoration: InputDecoration(
                labelText: "Address Link (optional)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: cityCtrl,
            decoration: InputDecoration(
                labelText: "City *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: ownerNameCtrl,
            decoration: InputDecoration(
                labelText: "Owner Name *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: contactCtrl,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                labelText: "Contact Number *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: secondaryCtrl,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                labelText: "Secondary Number (optional)",
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
            controller: monthlyFeesCtrl,
            decoration: InputDecoration(
                labelText: "Monthly Fees *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: coachesCtrl,
            decoration: InputDecoration(
                labelText: "Coaches *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "About Academy (optional)",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextFormField(
              controller: detailsCtrl,
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
                    if (selectedSport == null) {
                      Utility.showValidationToast("Please Select Sport");
                      return;
                    } else {
                      // Utility.showToast(
                      //     "Selected Sport ${selectedSport!.sportName} - ${selectedSport!.id}");
                    }

                    if (Utility.checkValidation(nameCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Academy Name");
                      return;
                    }

                    if (Utility.checkValidation(addressCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Address");
                      return;
                    }

                    if (Utility.checkValidation(cityCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter City");
                      return;
                    }

                    if (Utility.checkValidation(
                        ownerNameCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Owner Name");
                      return;
                    }

                    if (Utility.checkValidation(contactCtrl.text.toString())) {
                      Utility.showValidationToast(
                          "Please Enter Contact Number");
                      return;
                    }

                    if (Utility.checkValidation(
                        monthlyFeesCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Monthly Fees");
                      return;
                    }

                    if (Utility.checkValidation(coachesCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Coaches");
                      return;
                    }

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var playerId = prefs.get("playerId");
                    var locationId = prefs.get("locationId");
                    service = new Service();

                    service!.locationId = locationId!.toString();
                    service!.playerId = playerId!.toString();
                    service!.serviceId = widget.serviceId.toString();
                    service!.name = nameCtrl.text.toString();
                    service!.address = addressCtrl.text.toString();
                    service!.city = cityCtrl.text.toString();
                    service!.contactName = ownerNameCtrl.text.toString();
                    service!.contactNo = contactCtrl.text.toString();
                    service!.secondaryNo = secondaryCtrl.text.toString();
                    service!.about = detailsCtrl.text.toString();
                    service!.locationLink = addressLinkCtrl.text.toString();
                    service!.monthlyFees = monthlyFeesCtrl.text.toString();
                    service!.coaches = coachesCtrl.text.toString();
                    service!.feesPerMatch = "";
                    service!.feesPerDay = "";
                    service!.experience = textFacilityController.text;
                    service!.sportName = selectedSport!.sportName;
                    service!.sportId = selectedSport!.id.toString();
                    service!.companyName = "";

                    if (this.image != null) {
                      addService(this.image!.path, service!);
                      // Utility.showToast("File Selected Image");
                    } else {
                      Utility.showValidationToast("Please Select Image");
                    }
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
        print("Success");
        Utility.showToast("Service Created Successfully");
        var result = Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ServicePhotos(serviceDataId: id)));
        if (result == true) {
          Utility.showToast("Result $result");
        }
      }
    }
  }
}
