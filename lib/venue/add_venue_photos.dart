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
import 'package:player/model/venue_photo.dart';
import 'package:path/path.dart' as p;

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
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.check,
                  size: 30,
                  color: kBaseColor,
                ),
              )),
        ],
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
              RoundedButton(
                  title: "Add More Photos",
                  color: kBaseColor,
                  onPressed: () {
                    pickImage();
                  },
                  minWidth: 250,
                  txtColor: Colors.white),
              SizedBox(height: k20Margin),
              Container(),
              myPhotos(),
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
      if (this.image != null) {
        await addVenuePhoto(this.image!.path);
      }
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

  // Widget addVenueForm() {
  //   return Container(
  //     margin: EdgeInsets.all(10.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         RoundedButton(
  //             title: "Add More Photos",
  //             color: kBaseColor,
  //             onPressed: () {
  //               pickImage();
  //             },
  //             minWidth: 250,
  //             txtColor: Colors.white),
  //         SizedBox(height: k20Margin),
  //         Container(),
  //         myPhotos(),
  //       ],
  //     ),
  //   );
  // }

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

            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Photos'),
                ),
              );
            } else {
              return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return photoItem(snapshot.data![index]);
                  });
              // return ListView.builder(
              //   padding: EdgeInsets.only(bottom: 250),
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   itemCount: snapshot.data.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return photoItem(snapshot.data[index]);
              //   },
              // );
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
        print("photo null");
      } else {
        if (venuePhoto.status!) {
          // print("photo Success");
          //Utility.showToast("Timeslot Get Successfully");
          // timeslots!.clear();
          photos = venuePhoto.photos;
//          Navigator.pop(context);
        } else {
          print("photo Failed");
        }
      }
    }
    return photos;
  }

  photoItem(dynamic photo) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
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
            child: Container(
              child: Icon(
                Icons.delete_forever,
                color: kBaseColor,
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () async {
          //     await deleteVenuePhoto(photo.id.toString());
          //   },
          //   child: Expanded(
          //     flex: 1,
          //     child: Icon(
          //       Icons.delete_forever,
          //       color: kBaseColor,
          //     ),
          //   ),
          // )
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
