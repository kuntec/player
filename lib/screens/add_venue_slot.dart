import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/add_venue_photos.dart';

class AddVenueSlot extends StatefulWidget {
  const AddVenueSlot({Key? key}) : super(key: key);

  @override
  _AddVenueSlotState createState() => _AddVenueSlotState();
}

class _AddVenueSlotState extends State<AddVenueSlot> {
  File? image;
  TimeOfDay? openTime;
  TimeOfDay? closeTime;

  var txtOpenTime = "Open Time";
  var txtCloseTime = "Close Time";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Venue Slots")),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBaseColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(kMargin),
          child: Column(
            children: [
              addVenueForm(),
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

  Future pickTime(BuildContext context, bool isOpen) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return;

    if (newTime == null) return;
    setState(() {
      openTime = newTime;
      if (openTime != null) {
        if (isOpen) {
          if (openTime!.hour < 10) {
            var hour = "0" + openTime!.hour.toString();
            if (openTime!.minute < 10) {
              var minute = "0" + openTime!.minute.toString();
              txtOpenTime = "$hour:$minute";
            }
          }
          txtOpenTime = "${openTime!.hour}:${openTime!.minute}";
        } else {
          txtCloseTime = "${openTime!.hour}:${openTime!.minute}";
        }
      }
    });
  }

  Widget addVenueForm() {
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
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(10.0),
              //   child: CachedNetworkImage(
              //     imageUrl: imageURL,
              //     placeholder: (context, url) => Image(
              //       image: AssetImage('assets/images/no_user.jpg'),
              //     ),
              //   ),
              //   // child: Image(
              //   //   image: AssetImage(
              //   //     'assets/images/banner.jpg',
              //   //   ),
              //   //   width: MediaQuery.of(context).size.width,
              //   // ),
              // ),
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
            onChanged: (value) {
              // venueName = value;
            },
            decoration: InputDecoration(
                labelText: "Venue Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              // venueDescription = value;
            },
            decoration: InputDecoration(
                labelText: "Venue Description",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          // TextField(
          //   onChanged: (value) {
          //     tournamentName = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Tournament Name",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
          SizedBox(
            height: k20Margin,
          ),
          Container(
              child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    pickTime(context, true);
                  },
                  child: Text(
                    txtOpenTime,
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    pickTime(context, false);
                  },
                  child: Text(
                    txtCloseTime,
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: TextField(
              //     onTap: () {
              //       pickDate(context);
              //     },
              //     controller: txtEndDateController,
              //     // enabled: false,
              //     decoration: InputDecoration(
              //         prefixIcon: Icon(Icons.calendar_today_outlined),
              //         labelText: "End Date",
              //         labelStyle: TextStyle(
              //           color: Colors.grey,
              //         )),
              //   ),
              // ),
            ],
          )),

          SizedBox(height: k20Margin),
          RoundedButton(
            title: "NEXT",
            color: kBaseColor,
            txtColor: Colors.white,
            minWidth: 250,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddVenuePhotos()));
            },
          ),
        ],
      ),
    );
  }
}
