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
import 'package:shared_preferences/shared_preferences.dart';

class EditPhysioFitness extends StatefulWidget {
  dynamic service;
  EditPhysioFitness({required this.service});

  @override
  _EditPhysioFitnessState createState() => _EditPhysioFitnessState();
}

class _EditPhysioFitnessState extends State<EditPhysioFitness> {
  File? image;
  Service? service;
  bool? isLoading = false;
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController addressCtrl = new TextEditingController();
  TextEditingController contactCtrl = new TextEditingController();
  TextEditingController secondaryCtrl = new TextEditingController();
  TextEditingController experienceCtrl = new TextEditingController();
  TextEditingController cityCtrl = new TextEditingController();
  TextEditingController detailsCtrl = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCtrl.text = widget.service.name;
    contactCtrl.text = widget.service.contactNo;
    addressCtrl.text = widget.service.address;
    if (widget.service.secondaryNo == null) {
      secondaryCtrl.text = "";
    } else {
      secondaryCtrl.text = widget.service.secondaryNo;
    }
    experienceCtrl.text = widget.service.experience;
    cityCtrl.text = widget.service.city;
    detailsCtrl.text = widget.service.about;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Edit Physio Fitness"),
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
      await updatePosterImage(this.image!.path, widget.service.id.toString());
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
                    service!.sportName = "";
                    service!.sportId = "";
                    service!.companyName = nameCtrl.text;

                    updateService(service!);
                    //  print("Create Tournament");
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