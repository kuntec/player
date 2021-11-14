import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/player_data.dart';
import 'package:player/profile/edit_profile.dart';
import 'package:player/profile/favorite_sport.dart';
import 'package:player/profile/my_bookings.dart';
import 'package:player/profile/my_events.dart';
import 'package:player/profile/my_tournaments.dart';
import 'package:player/screens/login.dart';
import 'package:get/get.dart';
import 'package:player/services/servicewidgets/ServiceWidget.dart';
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
  Player? player;
  bool? isLoading = false;
  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  //   if (result == null) return;
  //   final path = result.files.single.path!;
  //   setState(() {
  //     file = File(path);
  //     print(file!.path);
  //   });
  // }
  //
  // uploadFile() {
  //   if (file == null) return;
  //   final fileName = basename(file!.path);
  //   final destination = 'files/$fileName';
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Player"),
        actions: [
          // RoundedButton(
          //   title: "Logout",
          //   color: kBaseColor,
          //   onPressed: () {
          //     logout(context);
          //   },
          //   minWidth: 100,
          //   txtColor: Colors.white,
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isLoading == true
                    ? Center(
                        child: Container(
                          child: Text("Loading"),
                        ),
                      )
                    : profileImageUpdate(),
                isLoading == true ? SizedBox.shrink() : profileInfo(context),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  profileInfo(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(
              "${player!.name}",
              style: TextStyle(
                fontSize: 20.0,
                color: kBaseColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text(
              "${player!.mobile}",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: kMargin),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(
                    player: player,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(kMargin),
              decoration: kServiceBoxItem.copyWith(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "My Profile",
                  style: TextStyle(color: kBaseColor, fontSize: 16.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteSport(
                    player: player,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(kMargin),
              decoration: kServiceBoxItem.copyWith(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Favorite Sport",
                  style: TextStyle(color: kBaseColor, fontSize: 16.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyTournaments(
                    player: player,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(kMargin),
              decoration: kServiceBoxItem.copyWith(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "My Tournaments",
                  style: TextStyle(color: kBaseColor, fontSize: 16.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyEvents(
                    player: player,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(kMargin),
              decoration: kServiceBoxItem.copyWith(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "My Events",
                  style: TextStyle(color: kBaseColor, fontSize: 16.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyBookings(
                    player: player,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(kMargin),
              decoration: kServiceBoxItem.copyWith(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "My Bookings",
                  style: TextStyle(color: kBaseColor, fontSize: 16.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              logout(context);
            },
            child: Container(
              margin: EdgeInsets.all(kMargin),
              decoration: kServiceBoxItem.copyWith(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  profileImageUpdate() {
    return Container(
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
                  backgroundImage: AssetImage('assets/images/no_user.jpg'),
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )),
                );
              } else {
                if (player != null) {
                  return CachedNetworkImage(
                    imageUrl: APIResources.IMAGE_URL + player!.image.toString(),
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => CircleAvatar(
                      backgroundImage: AssetImage('assets/images/no_user.jpg'),
                      child: Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                } else {
                  return CircleAvatar(
                    backgroundImage: AssetImage('assets/images/no_user.jpg'),
                  );
                }
              }
            }),
            Positioned(
              right: 16,
              bottom: 0,
              child: GestureDetector(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    "assets/images/Camera Icon.svg",
                    color: kBaseColor,
                  ),
                ),
                onTap: () async {
                  print("Camera Clicked");
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  int? playerId = prefs.getInt("playerId");
                  print("Player id " + playerId.toString());
                  String url = await profilerController.uploadImage(
                      ImageSource.gallery, playerId.toString());

                  if (!Utility.checkValidation(url)) {
                    Utility.showToast(url);
                    setState(() {
                      player!.image = url;
                    });
                  } else {
                    // Utility.showToast("Nothing");
                  }
                  //await getMyProfile();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  getMyProfile() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var playerId = prefs.get("playerId");
    var playerName = prefs.get("playerName");
    var mobile = prefs.get("mobile");
    //Utility.showToast("Player ${playerId} mobile ${mobile}");
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      print("Player " + mobile.toString());
//      showToast("Player " + phoneNumber);
      PlayerData playerData = await apiCall.checkPlayer(mobile.toString());

      if (playerData.status!) {
        setState(() {
          player = playerData.player;
          isLoading = false;
        });
        //  Utility.showToast("Player Found ${playerData.player!.image}");
      }
    }
  }
}
