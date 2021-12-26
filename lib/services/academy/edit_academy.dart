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
import 'package:player/venue/venue_facilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class EditAcademy extends StatefulWidget {
  dynamic service;
  EditAcademy({required this.service});

  @override
  _EditAcademyState createState() => _EditAcademyState();
}

class _EditAcademyState extends State<EditAcademy> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCtrl.text = widget.service.name;
    addressCtrl.text = widget.service.address;
    widget.service.locationLink == null
        ? addressLinkCtrl.text = ""
        : addressLinkCtrl.text = widget.service.locationLink;
    cityCtrl.text = widget.service.city;
    ownerNameCtrl.text = widget.service.contactName;
    contactCtrl.text = widget.service.contactNo;
    widget.service.secondaryNo == null
        ? secondaryCtrl.text = ""
        : secondaryCtrl.text = widget.service.secondaryNo;
    monthlyFeesCtrl.text = widget.service.monthlyFees;
    coachesCtrl.text = widget.service.coaches;
    textFacilityController.text = widget.service.experience;
    widget.service.about == null
        ? detailsCtrl.text = ""
        : detailsCtrl.text = widget.service.about;
    selectedFacilities = textFacilityController.text.split(", ");
    print("Facilities ${selectedFacilities}");
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
        title: Text("Edit Academy"),
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
          //             width: 280,
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
          SizedBox(height: kMargin),
          sports != null
              ? buildSportData(sports!)
              : Container(child: Text("Loading...")),
          SizedBox(height: kMargin),
          TextField(
            controller: nameCtrl,
            decoration: InputDecoration(
                labelText: "Academy Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: addressCtrl,
            decoration: InputDecoration(
                labelText: "Address",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: addressLinkCtrl,
            decoration: InputDecoration(
                labelText: "Address Link",
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
            controller: ownerNameCtrl,
            decoration: InputDecoration(
                labelText: "Owner Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: contactCtrl,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                labelText: "Contact Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: secondaryCtrl,
            keyboardType: TextInputType.phone,
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
            controller: monthlyFeesCtrl,
            decoration: InputDecoration(
                labelText: "Monthly Fees",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            controller: coachesCtrl,
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
                    if (selectedSport == null) {
                      Utility.showToast("Please Select Sport");
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
                    service = widget.service;

                    service!.locationId = locationId!.toString();
                    service!.playerId = playerId!.toString();
                    service!.serviceId = widget.service.serviceId.toString();
                    service!.name = nameCtrl.text;
                    service!.address = addressCtrl.text;
                    service!.city = cityCtrl.text;
                    service!.contactName = ownerNameCtrl.text;
                    service!.contactNo = contactCtrl.text;
                    service!.secondaryNo = secondaryCtrl.text;
                    service!.about = detailsCtrl.text;
                    service!.locationLink = addressLinkCtrl.text;
                    service!.monthlyFees = monthlyFeesCtrl.text;
                    service!.coaches = coachesCtrl.text;
                    service!.feesPerMatch = "";
                    service!.feesPerDay = "";
                    service!.experience = textFacilityController.text;
                    service!.sportName = selectedSport!.sportName;
                    service!.sportId = selectedSport!.id.toString();
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
