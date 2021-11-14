import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/my_sport.dart';
import 'package:player/model/player_data.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/screens/home.dart';
import 'package:player/screens/main_navigation.dart';
import 'package:player/venue/model/sport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class FavoriteSport extends StatefulWidget {
  dynamic player;
  FavoriteSport({this.player});

  @override
  _FavoriteSportState createState() => _FavoriteSportState();
}

class _FavoriteSportState extends State<FavoriteSport> {
  bool? checked = false;
  int? playerId;
  var currentSelectedSport;
  var selectedList = [];
  List<Sports> sports = [];
  List<Data> allSports = [];
  bool? isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMySports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: isLoading == true
          ? Container(
              alignment: Alignment.center,
              height: 40,
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () async {
                log(selectedList.toString());
//          print(selectedList);
                await this.addSport();
                // APICall apiCall = new APICall();
                // var response = await apiCall.addPlayerSport(
                //     widget.player!.id, selectedList.toString());
                // log("Response Sport Select =  $response");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: kBaseColor),
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 35.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
      appBar: AppBar(
        title: Text("Favorite Sport"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: k20Margin,
              ),
              Center(
                child: Text(
                  "Choose Sport",
                  style: const TextStyle(
                    color: kBaseColor,
                    fontStyle: FontStyle.normal,
                    fontSize: 40.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 700,
                child: FutureBuilder<List<Data>>(
                  future: getSports(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          padding: EdgeInsets.only(bottom: 200),
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return sportItem(snapshot.data![index]);
                          });
                    } else if (snapshot.hasError) {
                      return Text("Error");
                    }
                    return Text("Loading...");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Sports>> getMySports() async {
    APICall apiCall = new APICall();
    // List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      MySport mySport = await apiCall.getMySports(playerId.toString());

      if (mySport.sports != null) {
        sports.addAll(mySport.sports!);

        for (int i = 0; i < sports.length; i++) {
          int id = int.parse(sports[i].sportId.toString());
          selectedList.add(id);
        }
        print("Selected Sport 1 ${selectedList.toString()}");
        setState(() {});
      }
    } else {}
    return sports;
  }

  Future<List<Data>> getSports() async {
    APICall apiCall = new APICall();
    List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SportData sportData = await apiCall.getSports();

      if (sportData.data != null) {
        data.addAll(sportData.data!);
        allSports = data;
      }
    } else {}
    return data;
  }

  sportItem(dynamic data) {
    return GestureDetector(
      onTap: () {
        print("${data.id}");
        currentSelectedSport = data.id;

        for (int i = 0; i < selectedList.length; i++) {
          if (selectedList[i] == currentSelectedSport) {
            print("Found double");
            selectedList.remove(currentSelectedSport);
            setState(() {});
            return;
          } else {}
        }
        selectedList.add(currentSelectedSport);

        setState(() {});
        print("Selected Sport 2 ${selectedList.toString()}");
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 80,
        height: 80,
        decoration: kServiceBoxItem.copyWith(
            color: selectedList.any((element) => element == data.id)
                ? kBaseColor
                : Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: selectedList.any((element) => element == data.id)
                          ? Icon(
                              Icons.check,
                              size: 15.0,
                              color: kBaseColor,
                            )
                          : SizedBox(
                              height: 15.0,
                            )),
                ),
              ],
            ),
            // Icon(
            //   Icons.check_circle,
            //   color: Colors.white,
            // ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                data.sportName,
                style: TextStyle(
                    color: selectedList.any((element) => element == data.id)
                        ? Colors.white
                        : kBaseColor,
                    fontSize: 18.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.0, top: 40),
                  height: 50,
                  width: 50,
                  child: Image.network(
                      selectedList.any((element) => element == data.id)
                          ? APIResources.IMAGE_URL + data.sportIcon
                          : APIResources.IMAGE_URL + data.activeIcon),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future addSport() async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    log("Add player sport");
    String sport_id = "";
    selectedList.forEach((element) {
      sport_id += element.toString() + ",";
    });
    if (sport_id.length > 0) {
      sport_id = sport_id.substring(0, sport_id.length - 1);
    }

    if (connectivityStatus) {
      log("connection yes ${widget.player!.id}");
      log("connection yes ${sport_id}");

      PlayerData playerData =
          await apiCall.addPlayerSport(widget.player!.id.toString(), sport_id);
      setState(() {
        isLoading = false;
      });
      if (playerData.status!) {
        Navigator.pop(context);
      }

      // PlayerData playerData =
      //     await apiCall.addPlayer(name, phoneNumber, dob, gender);
      // if (playerData.status!) {
      //   showToast(playerData.message!);
      //   // Go to Sport Selection
      //   // (playerData.player != null) {
      //   //   String userId = value.user!.uid;
      //
      //   if (playerData.player != null) {
      //     int? playerId = playerData.player!.id;
      //     String? playerName = playerData.player!.name;
      //     String? locationId = playerData.player!.locationId;
      //     String? playerImage = playerData.player!.image;
      //
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     prefs.setInt("playerId", playerId!);
      //     prefs.setString("playerName", playerName!);
      //     //prefs.setString("playerImage", playerImage!);
      //     //prefs.setString("locationId", locationId!);
      //     prefs.setBool('isLogin', true);
      //     Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => SportSelect(
      //                   playerId: playerId.toString(),
      //                 )));
      //   }
      // } else {
      //   showToast(playerData.message!);
      // }
    } else {
      showToast(kInternet);
    }
  }
}
