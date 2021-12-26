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
import 'package:player/model/service_model.dart';
import 'package:player/model/sport_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class EditHelper extends StatefulWidget {
  dynamic service;
  EditHelper({required this.service});

  @override
  _EditHelperState createState() => _EditHelperState();
}

class _EditHelperState extends State<EditHelper> {
  File? image;
  Service? service;
  bool? isLoading = false;

  TextEditingController nameCtrl = new TextEditingController();
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
    cityCtrl.text = widget.service.city;
    contactCtrl.text = widget.service.contactNo;
    if (widget.service.secondaryNo == null) {
      secondaryCtrl.text = "";
    } else {
      secondaryCtrl.text = widget.service.secondaryNo;
    }
    experienceCtrl.text = widget.service.experience;
    if (widget.service.about == null) {
      detailsCtrl.text = "";
    } else {
      detailsCtrl.text = widget.service.about;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Edit Helper"),
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

      var file = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));

      if (file == null) return;

      file = await compressImage(file.path, 35);

      final imageTemporary = File(file.path);
      setState(() {
        this.image = imageTemporary;
      });
      await updatePosterImage(this.image!.path, widget.service.id.toString());
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
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    )
                  : widget.service.posterImage != null
                      ? Image.network(
                          APIResources.IMAGE_URL + widget.service.posterImage,
                          width: 150,
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
                labelText: "Name *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: contactCtrl,
            decoration: InputDecoration(
                labelText: "Primary Number *",
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
                  title: "UPDATE",
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

                    service = widget.service;

                    service!.locationId = locationId!.toString();
                    service!.playerId = playerId!.toString();
                    service!.serviceId = widget.service.serviceId.toString();
                    service!.name = nameCtrl.text;
                    service!.address = "";
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
                    service!.companyName = "";
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
      ServiceModel serviceModel = await apiCall.updateServiceData(service);
      setState(() {
        isLoading = false;
      });
      if (serviceModel.status!) {
        Utility.showToast("Service Updated Successfully");
        Navigator.pop(context, true);
      } else {
        Utility.showValidationToast("Something Went Wrong");
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
