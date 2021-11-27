import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/location_data.dart';
import 'package:player/model/player_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  dynamic player;
  EditProfile({this.player});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? gender = "";
  bool isLoading = false;
  DateTime? date;
  var txtDate = "Select Date";

  TextEditingController txtDateController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
//  TextEditingController dobController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    nameController.text = widget.player.name;
    txtDateController.text = widget.player.dob;
    if (widget.player.email == null) {
      widget.player.email = "";
    }
    emailController.text = widget.player.email;
    gender = widget.player.gender;
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 90),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return;
    setState(() {
      date = newDate;
      if (date == null) {
        txtDate = "Select Date";
      } else {
        txtDate = "${date!.day}-${date!.month}-${date!.year}";
      }
      txtDateController.text = txtDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            updateForm(),
          ],
        ),
      ),
    );
  }

  updateForm() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
            cursorColor: kBaseColor,
          ),
          SizedBox(
            height: k20Margin,
          ),
          TextField(
            controller: txtDateController,
            readOnly: true,
            keyboardType: TextInputType.text,
            onTap: () async {
              pickDate(context);
            },
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
                labelText: "Enter Birthday",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          // TextField(
          //   controller: dobController,
          //   keyboardType: TextInputType.text,
          //   style: TextStyle(
          //     color: Colors.black,
          //   ),
          //   decoration: InputDecoration(
          //       labelText: "Enter Birthday",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          //   cursorColor: kBaseColor,
          // ),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
                labelText: "Enter Email",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
            cursorColor: kBaseColor,
          ),
          SizedBox(
            height: k20Margin,
          ),
          Text("Select Gender"),
          SizedBox(
            height: k20Margin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                value: "Male",
                groupValue: gender,
                onChanged: (value) {
                  gender = value.toString();
                  setState(() {});
                },
              ),
              SizedBox(width: 10.0),
              GestureDetector(
                  onTap: () {
                    gender = "Male";
                    setState(() {});
                  },
                  child: Text("Male")),
              Radio(
                value: "Female",
                groupValue: gender,
                onChanged: (value) {
                  gender = value.toString();
                  setState(() {});
                },
              ),
              SizedBox(width: 10.0),
              GestureDetector(
                  onTap: () {
                    gender = "Female";
                    setState(() {});
                  },
                  child: Text("Female")),
              Radio(
                value: "Other",
                groupValue: gender,
                onChanged: (value) {
                  gender = value.toString();
                  setState(() {});
                },
              ),
              SizedBox(width: 10.0),
              GestureDetector(
                  onTap: () {
                    gender = "Other";
                    setState(() {});
                  },
                  child: Text("Other")),
            ],
          ),
          locations != null
              ? buildLocationData(locations!)
              : Container(child: Text("Loading...")),
          isLoading
              ? CircularProgressIndicator()
              : RoundedButton(
                  title: "UPDATE",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    widget.player.name = nameController.text;
                    widget.player.dob = txtDateController.text;
                    widget.player.email = emailController.text;
                    widget.player.gender = gender;
                    widget.player.locationId =
                        this.selectedLocation!.id.toString();
                    widget.player.city = this.selectedLocation!.name.toString();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString(
                        "locationId", widget.player!.locationId.toString());
                    prefs.setString("city", widget.player!.city.toString());
                    await updatePlayer();
                  },
                ),
        ],
      ),
    );
  }

  updatePlayer() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      PlayerData playerData = await apiCall.updatePlayer(widget.player);
      if (playerData.status!) {
        showToast(playerData.message!);
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context, true);
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(playerData.message!);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showToast(kInternet);
    }
  }

  List<Location>? locations;
  getLocation() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      LocationData locationData = await apiCall.getLocation();

      if (locationData.location != null) {
        setState(() {
          locations = locationData.location;
          for (Location l in locations!) {
            if (l.id.toString() == widget.player.locationId.toString()) {
              this.selectedLocation = l;
            }
          }
        });
      }
    } else {
      showToast(kInternet);
    }
  }

  Location? selectedLocation;
  Widget buildLocationData(List<Location> location) {
    return DropdownButton<Location>(
      value: selectedLocation != null ? selectedLocation : null,
      hint: Text("Select Location"),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: kBaseColor,
      ),
      onChanged: (Location? newValue) {
        // this._selectedLK = newValue!;
        setState(() {
          this.selectedLocation = newValue!;
        });
      },
      items: location.map<DropdownMenuItem<Location>>((Location value) {
        return DropdownMenuItem<Location>(
          value: value,
          child: Text(value.name!),
        );
      }).toList(),
    );
  }
}
