import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_model.dart';
import 'package:player/model/sport_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPersonalCoach extends StatefulWidget {
  dynamic service;
  EditPersonalCoach({required this.service});

  @override
  _EditPersonalCoachState createState() => _EditPersonalCoachState();
}

class _EditPersonalCoachState extends State<EditPersonalCoach> {
  File? image;
  Service? service;
  bool? isLoading = false;

  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController addressCtrl = new TextEditingController();
  TextEditingController cityCtrl = new TextEditingController();
  TextEditingController contactCtrl = new TextEditingController();
  TextEditingController secondaryCtrl = new TextEditingController();
  TextEditingController experienceCtrl = new TextEditingController();
  TextEditingController detailsCtrl = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCtrl.text = widget.service.name;
    addressCtrl.text = widget.service.address;
    cityCtrl.text = widget.service.city;
    contactCtrl.text = widget.service.contactNo;
    secondaryCtrl.text = widget.service.secondaryNo;
    experienceCtrl.text = widget.service.experience;
    detailsCtrl.text = widget.service.about;
    getSports();
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
          for (var s in sports!) {
            if (s.id.toString() == widget.service.sportId.toString()) {
              this.selectedSport = s;
            }
          }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Edit Personal Coach"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              updateServiceForm(),
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
      await updatePosterImage(this.image!.path, widget.service.id.toString());
    } on PlatformException catch (e) {
      print("Failed to pick image : $e");
    }
  }

  Widget updateServiceForm() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // GestureDetector(
          //   onTap: () {
          //     pickImage();
          //   },
          //   child: Container(
          //     margin: EdgeInsets.all(5.0),
          //     child: image != null
          //         ? Image.file(
          //             image!,
          //             width: 150,
          //             height: 150,
          //             fit: BoxFit.fill,
          //           )
          //         : FlutterLogo(size: 100),
          //   ),
          // ),
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
                  : widget.service.posterImage != null
                      ? Image.network(
                          APIResources.IMAGE_URL + widget.service.posterImage,
                          width: 280,
                          height: 150,
                          fit: BoxFit.fill,
                        )
                      : FlutterLogo(size: 100),
            ),
          ),
          isLoading == true
              ? CircularProgressIndicator()
              : GestureDetector(
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
            controller: nameCtrl,
            decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: contactCtrl,
            decoration: InputDecoration(
                labelText: "Contact Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: secondaryCtrl,
            decoration: InputDecoration(
                labelText: "Secondary Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: addressCtrl,
            decoration: InputDecoration(
                labelText: "Address",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: cityCtrl,
            decoration: InputDecoration(
                labelText: "City",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: experienceCtrl,
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
                  title: "UPDATE",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: 150,
                  onPressed: () async {
//              if (widget.isEdit) {}
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var playerId = prefs.get("playerId");
                    service = widget.service;

                    service!.playerId = playerId!.toString();
                    service!.serviceId = widget.service.serviceId.toString();
                    service!.name = nameCtrl.text;
                    service!.address = addressCtrl.text;
                    service!.city = cityCtrl.text;
                    service!.contactName = "";
                    service!.contactNo = contactCtrl.text;
                    service!.secondaryNo = secondaryCtrl.text;
                    service!.about = detailsCtrl.text;
                    service!.locationLink = "";
                    service!.monthlyFees = "";
                    service!.coaches = "";
                    service!.feesPerMatch = "";
                    service!.feesPerDay = "";
                    service!.experience = experienceCtrl.text;
                    service!.sportName = selectedSport!.sportName.toString();
                    service!.sportId = selectedSport!.id.toString();
                    service!.companyName = nameCtrl.text;

                    updateService(service!);
                  },
                ),
        ],
      ),
    );
  }

  updateService(Service service) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic id = await apiCall.updateServiceData(service);
      setState(() {
        isLoading = false;
      });
      if (id == null) {
        print("null");
        Utility.showToast("Failed");
      } else {
        print("Success $id");
        Utility.showToast("Service Updated Successfully");
        Navigator.pop(context, true);
      }
    }
  }

  updatePosterImage(String filePath, String id) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic status = await apiCall.updateServicePosterImage(filePath, id);
      setState(() {
        isLoading = false;
      });
      Utility.showToast("Poster Image Updated Successfully");
      if (status == null) {
        print("Poster null");
      } else {
        if (status!) {
          print("Poster Success");
          Utility.showToast("Poster Image Updated Successfully");
          //Navigator.pop(context);
        } else {
          print("Poster Failed");
        }
      }
    }
  }
}
