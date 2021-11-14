import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/player_data.dart';

class EditProfile extends StatefulWidget {
  dynamic player;
  EditProfile({this.player});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? gender = "";
  bool isLoading = false;

  TextEditingController nameController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.player.name;
    dobController.text = widget.player.dob;
    if (widget.player.email == null) {
      widget.player.email = "";
    }
    emailController.text = widget.player.email;
    gender = widget.player.gender;
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
            controller: dobController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
                labelText: "Enter Birthday",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
            cursorColor: kBaseColor,
          ),
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
                    widget.player.dob = dobController.text;
                    widget.player.email = emailController.text;
                    widget.player.gender = gender;
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
}
