import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

class EditSportMarket extends StatefulWidget {
  dynamic service;
  EditSportMarket({required this.service});

  @override
  _EditSportMarketState createState() => _EditSportMarketState();
}

class _EditSportMarketState extends State<EditSportMarket> {
  File? image;
  Service? service;
  bool? isLoading = false;

  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController ownerNameCtrl = new TextEditingController();
  TextEditingController contactCtrl = new TextEditingController();
  TextEditingController secondaryContactCtrl = new TextEditingController();
  TextEditingController addressCtrl = new TextEditingController();
  TextEditingController addressLinkCtrl = new TextEditingController();
  TextEditingController cityCtrl = new TextEditingController();
  TextEditingController detailsCtrl = new TextEditingController();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCtrl.text = widget.service.name;
    ownerNameCtrl.text = widget.service.contactName;
    contactCtrl.text = widget.service.contactNo;
    if (widget.service.secondaryNo == null) {
      secondaryContactCtrl.text = "";
    } else {
      secondaryContactCtrl.text = widget.service.secondaryNo;
    }

    addressCtrl.text = widget.service.address;

    if (widget.service.locationLink == null) {
      addressLinkCtrl.text = "";
    } else {
      addressLinkCtrl.text = widget.service.locationLink;
    }

    cityCtrl.text = widget.service.city;

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
        title: Text("Edit Sport Market ${widget.service.id.toString()}"),
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

  Widget updateServiceForm() {
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
                labelText: "Shop Name *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: addressCtrl,
            decoration: InputDecoration(
                labelText: "Address *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            keyboardType: TextInputType.text,
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
            controller: secondaryContactCtrl,
            decoration: InputDecoration(
                labelText: "Secondary Number (optional)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            enabled: false,
            decoration: InputDecoration(
                labelText: "Details of Shop (optional)",
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
              ? CircularProgressIndicator(
                  color: kBaseColor,
                )
              : RoundedButton(
                  title: "UPDATE",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: 150,
                  onPressed: () async {
                    if (Utility.checkValidation(nameCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Shop Name");
                      return;
                    }

                    if (Utility.checkValidation(
                        ownerNameCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Owner Name");
                      return;
                    }

                    if (Utility.checkValidation(contactCtrl.text.toString())) {
                      Utility.showValidationToast(
                          "Please Enter Primary Contact Number");
                      return;
                    }

                    if (Utility.checkValidation(cityCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter City");
                      return;
                    }

                    if (Utility.checkValidation(addressCtrl.text.toString())) {
                      Utility.showValidationToast("Please Enter Address");
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
                    service!.name = nameCtrl.text.toString();
                    service!.address = addressCtrl.text.toString();
                    service!.city = cityCtrl.text.toString();
                    service!.contactName = ownerNameCtrl.text.toString();
                    service!.contactNo = contactCtrl.text.toString();
                    service!.secondaryNo = secondaryContactCtrl.text.toString();
                    service!.about = detailsCtrl.text.toString();
                    service!.locationLink = addressLinkCtrl.text.toString();
                    service!.monthlyFees = "";
                    service!.coaches = "";
                    service!.feesPerMatch = "";
                    service!.feesPerDay = "";
                    service!.experience = "";
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
