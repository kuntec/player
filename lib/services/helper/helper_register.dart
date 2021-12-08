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

class HelperRegister extends StatefulWidget {
  dynamic serviceId;

  HelperRegister({this.serviceId});

  @override
  _HelperRegisterState createState() => _HelperRegisterState();
}

class _HelperRegisterState extends State<HelperRegister> {
  File? image;
  Service? service;
  bool? isLoading = false;

  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController cityCtrl = new TextEditingController();
  TextEditingController contactCtrl = new TextEditingController();
  TextEditingController secondaryCtrl = new TextEditingController();
  TextEditingController experienceCtrl = new TextEditingController();
  TextEditingController detailsCtrl = new TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getSports();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Helper Register"),
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
            controller: nameCtrl,
            decoration: InputDecoration(
                labelText: "Name *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: contactCtrl,
            decoration: InputDecoration(
                labelText: "Primary Number  *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: secondaryCtrl,
            decoration: InputDecoration(
                labelText: "Secondary Number (optional)",
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
            controller: experienceCtrl,
            decoration: InputDecoration(
                labelText: "Experience *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            enabled: false,
            decoration: InputDecoration(
                labelText: "More Details (optional)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
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
                    if (Utility.checkValidation(nameCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Name");
                      return;
                    }

                    if (Utility.checkValidation(contactCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Number");
                      return;
                    }

                    if (Utility.checkValidation(cityCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter City");
                      return;
                    }

                    if (Utility.checkValidation(
                        experienceCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Experience");
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
                    service!.address = "";
                    service!.city = cityCtrl.text.toString();
                    service!.contactName = "";
                    service!.contactNo = contactCtrl.text.toString();
                    service!.secondaryNo = secondaryCtrl.text.toString();
                    service!.about = detailsCtrl.text.toString();
                    service!.locationLink = "";
                    service!.monthlyFees = "";
                    service!.coaches = "";
                    service!.feesPerMatch = "";
                    service!.feesPerDay = "";
                    service!.experience = experienceCtrl.text.toString();
                    service!.sportName = "";
                    service!.sportId = "";
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
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      ServiceModel serviceModel =
          await apiCall.addServiceData(filePath, service);
      setState(() {
        isLoading = false;
      });
      if (serviceModel.status!) {
        print("Success");
        Utility.showToast("Helper Created Successfully");
        Navigator.pop(context);
      } else {
        Utility.showValidationToast("Something Went Wrong");
      }
    }
  }

//   List<Data>? sports;
//   Data? selectedSport;
//   Future<List<Data>> getSports() async {
//     APICall apiCall = new APICall();
//     List<Data> list = [];
//     bool connectivityStatus = await Utility.checkConnectivity();
//     if (connectivityStatus) {
//       SportData sportData = await apiCall.getSports();
//       if (sportData.data != null) {
//         list = sportData.data!;
//         setState(() {
//           sports = list;
// //          this.selectedSport = list[0];
//         });
//       }
//     }
//     return list;
//   }
//
//   Widget buildSportData(List<Data> data) {
//     return DropdownButton<Data>(
//       value: selectedSport != null ? selectedSport : null,
//       hint: Text("Select Sport"),
//       isExpanded: true,
//       icon: const Icon(Icons.keyboard_arrow_down),
//       iconSize: 24,
//       elevation: 16,
//       style: const TextStyle(color: Colors.black),
//       underline: Container(
//         height: 2,
//         color: kBaseColor,
//       ),
//       onChanged: (Data? newValue) {
//         // this._selectedLK = newValue!;
//         setState(() {
//           this.selectedSport = newValue!;
//         });
//       },
//       items: data.map<DropdownMenuItem<Data>>((Data value) {
//         return DropdownMenuItem<Data>(
//           value: value,
//           child: Text(value.sportName!),
//         );
//       }).toList(),
//     );
//   }
}
