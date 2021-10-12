import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:player/controller/ProfileController.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlayerProfile extends StatefulWidget {
  const PlayerProfile({Key? key}) : super(key: key);

  @override
  _PlayerProfileState createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  final ProfileController profilerController = Get.put(ProfileController());

  File? file;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
      print(file!.path);
    });
  }

  uploadFile() {
    if (file == null) return;
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   title: Text("Player"),
      // ),
      body: Column(
        children: [
          RoundedButton(
            title: "Logout",
            color: kAppColor,
            onPressed: () {
              logout(context);
            },
            minWidth: 200,
            txtColor: Colors.white,
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 40,
                ),
              ],
            ),
            child: SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                overflow: Overflow.visible,
                children: [
                  Obx(() {
                    if (profilerController.isLoading.value) {
                      return CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/no_user.jpg'),
                        child: Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )),
                      );
                    } else {
                      if (profilerController.imageURL.length != 0) {
                        return CachedNetworkImage(
                          imageUrl: profilerController.imageURL,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (context, url) => CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/no_user.jpg'),
                            child: Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        );
                      } else {
                        return CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/no_user.jpg'),
                        );
                      }
                    }
                  }),
                  Positioned(
                    right: 16,
                    bottom: 0,
                    child: GestureDetector(
                      child: SizedBox(
                        height: 36,
                        width: 36,
                        child:
                            SvgPicture.asset("assets/images/Camera Icon.svg"),
                      ),
                      onTap: () async {
                        print("Camera Clicked");
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        int? playerId = prefs.getInt("playerId");
                        print("Player id " + playerId.toString());
                        profilerController.uploadImage(
                            ImageSource.gallery, playerId.toString());
                        // Get.bottomSheet(Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: const BorderRadius.only(
                        //         topLeft: Radius.circular(16.0),
                        //         topRight: Radius.circular(16.0)),
                        //   ),
                        //   child: Wrap(
                        //     alignment: WrapAlignment.end,
                        //     crossAxisAlignment: WrapCrossAlignment.end,
                        //     children: [
                        //       ListTile(
                        //         leading: Icon(Icons.camera),
                        //         title: Text('Camera'),
                        //         onTap: () {
                        //           Get.back();
                        //           profilerController
                        //               .uploadImage(ImageSource.camera);
                        //         },
                        //       ),
                        //       ListTile(
                        //         leading: Icon(Icons.image),
                        //         title: Text('Gallery'),
                        //         onTap: () {
                        //           Get.back();
                        //           profilerController
                        //               .uploadImage(ImageSource.gallery);
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ));
                      },
                    ),
                  )

                  // Positioned(
                  //   right: -16,
                  //   bottom: 0,
                  //   child: SizedBox(
                  //     height: 46,
                  //     width: 46,
                  //     child: FlatButton(
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(50),
                  //         side: BorderSide(color: Colors.white),
                  //       ),
                  //       color: Colors.grey[200],
                  //       onPressed: () {
                  //         Get.bottomSheet(
                  //           Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: const BorderRadius.only(
                  //                   topLeft: Radius.circular(16.0),
                  //                   topRight: Radius.circular(16.0)),
                  //             ),
                  //             child: Wrap(
                  //               alignment: WrapAlignment.end,
                  //               crossAxisAlignment: WrapCrossAlignment.end,
                  //               children: [
                  //                 ListTile(
                  //                   leading: Icon(Icons.camera),
                  //                   title: Text('Camera'),
                  //                   onTap: () {
                  //                     Get.back();
                  //                     profilerController
                  //                         .uploadImage(ImageSource.camera);
                  //                   },
                  //                 ),
                  //                 ListTile(
                  //                   leading: Icon(Icons.image),
                  //                   title: Text('Gallery'),
                  //                   onTap: () {
                  //                     Get.back();
                  //                     profilerController
                  //                         .uploadImage(ImageSource.gallery);
                  //                   },
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //       child: SvgPicture.asset("assets/images/Camera Icon.svg"),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       RoundedButton(
      //         title: "Logout",
      //         color: kAppColor,
      //         onPressed: () {
      //           logout(context);
      //         },
      //         minWidth: 200,
      //         txtColor: Colors.white,
      //       ),
      //       RoundedButton(
      //         title: "Select File",
      //         color: kAppColor,
      //         onPressed: () {
      //           selectFile();
      //         },
      //         minWidth: 200,
      //         txtColor: Colors.white,
      //       ),
      //       SizedBox(height: k20Margin),
      //       //Text(fileName),
      //       SizedBox(height: k20Margin),
      //       RoundedButton(
      //         title: "Upload File",
      //         color: kAppColor,
      //         onPressed: () {},
      //         minWidth: 200,
      //         txtColor: Colors.white,
      //       ),
      //     ],
      //   ),
    ));
  }

  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }
}
