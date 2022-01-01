import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/model/player_data.dart';
import 'package:player/service/ImageService.dart';
import 'package:path/path.dart' as p;

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var imageURL = '';

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

  Future<String> uploadImage(ImageSource imageSource, String playerId) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);

      if (pickedFile == null) return "";

      var file = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));

      if (file == null) return "";

      file = await compressImage(file.path, 35);

      isLoading(true);
      if (pickedFile != null) {
        print("Player Id at upload $playerId");
        var response = await ImageService.uploadFile(file.path, playerId);
        print(response.toString());
        if (response.statusCode == 200) {
          //get image url from api response
          //imageURL = response.data['user']['image'];
          print("Image uploaded successfully");
//          PlayerData.fromJson(jsonDecode(response.body));

          PlayerData playerData =
              PlayerData.fromJson(jsonDecode(response.toString()));
          if (playerData.player!.image != null) {
            String? image = playerData.player!.image!;
//            print("Image " + image!);
            imageURL = image;
          }

          Get.snackbar('Success', 'Image uploaded successfully',
              margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        } else if (response.statusCode == 401) {
//          Get.offAllNamed('/sign_up');
        } else {
          print("Image uploaded Failed");
          Get.snackbar('Failed', 'Error Code: ${response.statusCode}',
              margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        }
      } else {
        print("Image not selected");
        Get.snackbar('Failed', 'Image not selected',
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));
      }
    } finally {
      isLoading(false);
    }
    return imageURL;
  }
}
