import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/venue_photo.dart';

class AddVenuePhotos extends StatefulWidget {
  dynamic venue;
  AddVenuePhotos({this.venue});

  @override
  _AddVenuePhotosState createState() => _AddVenuePhotosState();
}

class _AddVenuePhotosState extends State<AddVenuePhotos> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Venue Photos")),
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
      if (this.image != null) {
        await addVenuePhoto(this.image!.path);
      }
    } on PlatformException catch (e) {
      print("Failed to pick image : $e");
    }
  }

  Widget addVenueForm() {
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
          RoundedButton(
              title: "Add More Photos",
              color: kBaseColor,
              onPressed: () {
                pickImage();
              },
              minWidth: 250,
              txtColor: Colors.white),
          SizedBox(height: k20Margin),
          // GestureDetector(
          //   onTap: () async {
          //     print("Camera Clicked");
          //     // pickedFile =
          //     //     await ImagePicker().getImage(source: ImageSource.gallery);
          //     pickImage();
          //   },
          //   child: Container(
          //     child: Icon(
          //       Icons.camera_alt_outlined,
          //       size: 30,
          //       color: kBaseColor,
          //     ),
          //   ),
          // ),
          Container(),
          myPhotos(),
          // TextField(
          //   onChanged: (value) {
          //     // venueName = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Venue Name",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
          // TextField(
          //   onChanged: (value) {
          //     // venueDescription = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Venue Description",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
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
          // SizedBox(
          //   height: k20Margin,
          // ),
          // Container(
          //     child: Row(
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child: GestureDetector(
          //         onTap: () {
          //           pickTime(context, true);
          //         },
          //         child: Text(
          //           txtOpenTime,
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 20.0,
          //     ),
          //     Expanded(
          //       flex: 1,
          //       child: GestureDetector(
          //         onTap: () {
          //           pickTime(context, false);
          //         },
          //         child: Text(
          //           txtCloseTime,
          //         ),
          //       ),
          //     ),
          //
          //   ],
          // )),
          // Container(
          //   child: Row(
          //     children: [
          //       Expanded(
          //         flex: 1,
          //         child: TextField(
          //           onChanged: (value) {
          //             //entryFees = value;
          //           },
          //           decoration: InputDecoration(
          //               labelText: "Venue Location",
          //               labelStyle: TextStyle(
          //                 color: Colors.grey,
          //               )),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 20.0,
          //       ),
          //       Expanded(
          //         flex: 1,
          //         child: GestureDetector(
          //           onTap: () {
          //             pickTime(context);
          //           },
          //           child: Text(
          //             txtTime,
          //           ),
          //         ),
          //       ),
          //       // Expanded(
          //       //   flex: 1,
          //       //   child: TextField(
          //       //     decoration: InputDecoration(
          //       //         labelText: "Timing (From to To)",
          //       //         labelStyle: TextStyle(
          //       //           color: Colors.grey,
          //       //         )),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          // TextField(
          //   onChanged: (value) {
          //     //noOfMembers = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Venue Location",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
          // TextField(
          //   onChanged: (value) {
          //     // ageLimit = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Venue City",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
          // TextField(
          //   onChanged: (value) {
          //     // address = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Which Sport We can Play",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
          // TextField(
          //   onChanged: (value) {
          //     prizeDetails = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Prize Details",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
          // TextField(
          //   onChanged: (value) {
          //     otherInfo = value;
          //   },
          //   decoration: InputDecoration(
          //       labelText: "Any Other Information",
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //       )),
          // ),
          //SizedBox(height: k20Margin),
          // RoundedButton(
          //   title: "NEXT",
          //   color: kBaseColor,
          //   txtColor: Colors.white,
          //   minWidth: 250,
          //   onPressed: () async {},
          // ),
        ],
      ),
    );
  }

  addVenuePhoto(String filePath) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic addedVenue =
          await apiCall.addVenuePhoto(filePath, widget.venue.id.toString());

      if (addedVenue == null) {
        print("Venue Photo null");
        Utility.showToast("Venue Photo Null");
      } else {
        if (addedVenue) {
          print("Venue Success");
          Utility.showToast("Venue Photo Created Successfully");
          setState(() {});
        } else {
          print("Venue Photo Failed");
          Utility.showToast("Venue Photo Failed");
        }
      }
    }
  }

  Widget myPhotos() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(20.0),
      child: FutureBuilder(
        future: getPhotos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Loading....'),
              ),
            );
          }
          if (snapshot.hasData) {
            print("Has Data ${snapshot.data.length}");
            // return Container(
            //   child: Center(
            //     child: Text('Yes Data ${snapshot.data}'),
            //   ),
            // );
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Photos'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 250),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return photoItem(snapshot.data[index]);
                },
              );
            }

            // return GridView.builder(
            //     itemCount: snapshot.data!.length,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2),
            //     itemBuilder: (context, index) {
            //       return photoItem(snapshot.data![index]);
            //     });
          } else {
            return Container(
              child: Center(
                child: Text('No Data'),
              ),
            );
          }
        },
      ),
    );
  }

  List<Photos>? photos;

  Future<List<Photos>?> getPhotos() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      VenuePhoto venuePhoto =
          await apiCall.getVenuePhoto(widget.venue.id.toString());

      if (venuePhoto == null) {
        print("Timeslot null");
      } else {
        if (venuePhoto.status!) {
          print("Timeslot Success");
          //Utility.showToast("Timeslot Get Successfully");
          // timeslots!.clear();
          photos = venuePhoto.photos;
//          Navigator.pop(context);
        } else {
          print("Timeslot Failed");
        }
      }
    }
    return photos;
  }

  photoItem(dynamic photo) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            height: 200.0,
            width: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Image.network(
                APIResources.IMAGE_URL + photo.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await deleteVenuePhoto(photo.id.toString());
            },
            child: Expanded(
              flex: 1,
              child: Icon(
                Icons.delete_forever,
                color: kBaseColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  deleteVenuePhoto(String id) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      VenuePhoto venuePhoto = await apiCall.deleteVenuePhoto(id);

      if (venuePhoto == null) {
        print("Timeslot null");
      } else {
        if (venuePhoto.status!) {
          print("Timeslot Success");
          Utility.showToast("Photo Deleted Successfully");
          setState(() {});
        } else {}
      }
    }
  }
}
