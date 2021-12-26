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
import 'package:player/model/service_photo.dart';
import 'package:path/path.dart' as p;

class ServicePhotos extends StatefulWidget {
  final serviceDataId;

  ServicePhotos({required this.serviceDataId});
  @override
  _ServicePhotosState createState() => _ServicePhotosState();
}

class _ServicePhotosState extends State<ServicePhotos> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Photos"),
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
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              addPhotoForm(),
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
        await addServicePhoto(this.image!.path);
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

  Widget addPhotoForm() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }

  addServicePhoto(String filePath) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      dynamic status = await apiCall.addServicePhoto(
          filePath, widget.serviceDataId.toString());

      if (status == null) {
        print("Service Photo null");
        Utility.showToast("Service Photo Null");
      } else {
        if (status) {
          print("Service Success");
          Utility.showToast("Photo Added Successfully");
          setState(() {});
        } else {
          print("Service Photo Failed");
          Utility.showToast("Service Photo Failed");
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
            }
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
      ServicePhoto servicePhoto =
          await apiCall.getServicePhoto(widget.serviceDataId.toString());

      if (servicePhoto == null) {
        print("Photos null");
      } else {
        if (servicePhoto.status!) {
          print("Photos Success");
          photos = servicePhoto.photos;
        } else {
          print("Photos Failed1");
        }
      }
    }
    return photos;
  }

  photoItem(dynamic photo) {
    return Container(
//      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Container(
            height: 115.0,
            width: 115.0,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(
                APIResources.IMAGE_URL + photo.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              await deleteServicePhoto(photo.id.toString());
            },
            child: Icon(
              Icons.delete_forever,
              color: kBaseColor,
            ),
          )
        ],
      ),
    );
  }

  deleteServicePhoto(String id) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      ServicePhoto servicePhoto = await apiCall.deleteServicePhoto(id);

      if (servicePhoto == null) {
        print("Timeslot null");
      } else {
        if (servicePhoto.status!) {
          print("Timeslot Success");
          Utility.showToast("Photo Deleted Successfully");
          setState(() {});
        } else {}
      }
    }
  }
}
