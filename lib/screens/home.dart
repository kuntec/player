import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/chat/chat_page.dart';
import 'package:player/chatprovider/home_provider.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/firestore_constants.dart';
import 'package:player/constant/time_ago.dart';
import 'package:player/constant/utility.dart';
import 'package:player/event/event_screen.dart';
import 'package:player/friends/chat_screen.dart';
import 'package:player/friends/friend.dart';
import 'package:player/model/banner_data.dart';
import 'package:player/model/host_activity.dart';
import 'package:player/model/my_sport.dart';
import 'package:player/model/player_data.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/screens/add_host_activity.dart';
import 'package:player/screens/add_tournament.dart';
import 'package:player/screens/choose_sport.dart';
import 'package:player/screens/location_select.dart';
import 'package:player/screens/notification_screen.dart';
import 'package:player/screens/offer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Sports> sports = [];
  List<Data> allSports = [];
  List<Banners> banners = [];
  var city;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late HomeProvider homeProvider;
//  late String currentUserId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeProvider = context.read<HomeProvider>();
    getBanner();
    getMySports();
    getSports();
    getMyCity();
  }

  Future<void> getBanner() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      BannerData bannerData = await apiCall.getBanner();
      if (bannerData.banners != null) {
        banners = bannerData.banners!;
      }
    }
  }

  getMyCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    city = prefs.getString("city")!;
    setState(() {});
  }

  // void registerNotification() {
  //   firebaseMessaging.requestPermission();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     if (message.notification != null) {
  //       //Show Notification
  //     }
  //     return;
  //   });
  //
  //   firebaseMessaging.getToken().then((token) {
  //     if (token != null) {
  //       homeProvider.updateDataFirestore(FirestoreContants.pathUserCollection,
  //           currentUserId, {'pushToken': token});
  //     }
  //   }).catchError((error) {
  //     Utility.showToast("Error : ${error.message.toString()}");
  //   });
  // }

  // void configureLocalNotification() {
  //   AndroidInitializationSettings initializationAndroidSettings =
  //       AndroidInitializationSettings("");
  //   IOSInitializationSettings iosInitializationSettings =
  //       IOSInitializationSettings();
  //
  //   InitializationSettings initializationSettings = InitializationSettings(
  //       android: initializationAndroidSettings, iOS: iosInitializationSettings);
  //
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

//  void showNotification

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: GestureDetector(
        //   onTap: () async {
        //     var result = await Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => LocationSelectScreen()));
        //     getMyCity();
        //   },
        //   child: Icon(
        //     Icons.location_pin,
        //     color: kBaseColor,
        //   ),
        // ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            },
            child: Icon(
              Icons.notifications_active,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10.0),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatScreen()));
            },
            child: Icon(
              Icons.message,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10.0),
        ],
        title: GestureDetector(
          onTap: () async {
            var result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LocationSelectScreen()));
            if (result) {
              getMyCity();
            }
          },
          child: Row(
            children: [
              Icon(
                Icons.location_pin,
                color: kBaseColor,
              ),
              Text(
                city != null ? city : "",
                style: TextStyle(color: kBaseColor),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [banner(), homeButtonBar(), sportBarList(), hostActivity()],
        ),
      ),
    );
  }

  Widget banner() {
    return banners.length == 0
        ? SizedBox.shrink()
        : Container(
            margin: EdgeInsets.all(5),
            child: CarouselSlider.builder(
                itemCount: banners.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = banners[index].imgUrl.toString();
                  return buildImage(urlImage, index);
                },
                options: CarouselOptions(
                    viewportFraction: 1,
                    height: 110,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3))),
          );
    // : Container(
    //     height: 115,
    //     padding: EdgeInsets.all(10.0),
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(15.0),
    //       child: Image(
    //         image: AssetImage(
    //           'assets/images/dream11.png',
    //         ),
    //         fit: BoxFit.cover,
    //         width: MediaQuery.of(context).size.width,
    //       ),
    //     ),
    //   );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
//      margin: EdgeInsets.symmetric(horizontal: 2),
      child: Image.network(
        APIResources.IMAGE_URL + urlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget hostActivity() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(10.0),
      child: FutureBuilder(
        future: getHostActivity(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Loading...'),
              ),
            );
          }
          if (snapshot.hasData) {
            print("Has Data ${snapshot.data.length}");
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Data'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 20),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                //reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  return hostActivityItem2(snapshot.data[index]);
                },
              );
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

  Widget homeButtonBar() {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          iconCard(
              Icon(
                Icons.add,
                color: kBaseColor,
                size: 30,
              ),
              "Host Activity",
              1,
              hostEndColor, () async {
            var result = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddHost()));
            if (result == true) {
              setState(() {});
            }
          }, false),
          iconCard(
              Icon(
                Icons.people,
                color: kBaseColor,
                size: 30,
              ),
              "Friends",
              2,
              friendEndColor, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FriendScreen()));
          }, false),
          iconCard(Container(), "Host Tournament", 3, tournamentEndColor, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTournament()));
          }, true),
          iconCard(
              Icon(
                Icons.star,
                color: kBaseColor,
                size: 30,
              ),
              "Event",
              4,
              eventEndColor, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EventScreen()));
          }, false),
          iconCard(
              Icon(
                Icons.star,
                color: kBaseColor,
                size: 30,
              ),
              "Offers",
              5,
              offerEndColor, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OfferScreen()));
          }, false),
        ],
      ),
    );
  }

  Widget iconCard(Widget iconData, String title, int index, Color endColor,
      dynamic onPress, bool isTournament) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [startColor, endColor],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
            stops: [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: 85,
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isTournament == true
                  ? Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/images/tournament.svg",
                          height: 30,
                          width: 30,
                          fit: BoxFit.scaleDown,
                          color: kBaseColor,
                        ),
                      ),
                    )
                  : Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: iconData,
                    ),
              SizedBox(height: 10.0),
              Center(
                  child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              ))
            ],
          ),
        ),
      ),
    );
  }

  hostActivityItem2(dynamic activity) {
    return GestureDetector(
      onTap: () {
        //Utility.showToast("Activity To Chat ${activity.playerImage}");
        if (playerId.toString() == activity.playerId.toString()) {
          Utility.showToast("This is your Host Activity");
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                      playerId: activity.playerId.toString(),
                      peerId: activity.playerFuid.toString(), // send fuid
                      peerAvatar: activity.playerImage.toString(),
                      peerNickname: activity.playerName.toString())));
        }
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        decoration: kServiceBoxItem,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //image column
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
//                  padding: EdgeInsets.all(5.0),
                    height: 85.0,
                    width: 85.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        activity.playerImage == null
                            ? APIResources.AVATAR_IMAGE
                            : APIResources.IMAGE_URL + activity.playerImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        TimeAgo.timeAgoSinceDate(activity.createdAt),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //info Column
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SizedBox(height: 5.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          height: 20,
                          child: Text(
                            activity.playerName,
                            style: TextStyle(
                              color: kBaseColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              color: kBaseColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              )),
                          width: 90,
                          height: 30,
                          child: Center(
                            child: Text(
                              selectedSportId == "0"
                                  ? activity.sportName
                                  : activity.lookingForValue,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Looking For: ${activity.lookingFor}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Location: ${activity.area}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Time: ${activity.timing}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Date: ${activity.startDate}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    activity.ballType != null
                        ? "Ball Type: ${activity.ballType} "
                        : "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//   getPlayerById(String id) async {
//     APICall apiCall = new APICall();
//     bool connectivityStatus = await Utility.checkConnectivity();
//     if (connectivityStatus) {
//       PlayerData playerData = await apiCall.getPlayerById(id);
//
//       if (playerData.status!) {
// //        Utility.showToast("Player Found ${playerData.player!.name}");
//         // Utility.showToast("Player FUID ${playerData.player!.fuid}");
//
//       }
//     }
//   }

//   hostActivityItem(dynamic activity) {
//     return GestureDetector(
//       onTap: () {
//         Utility.showToast("${activity.sportName}");
//       },
//       child: Container(
//         margin: EdgeInsets.all(5.0),
//         decoration: kContainerBoxDecoration,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   color: kBaseColor,
//                   borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(10.0),
//                     topLeft: Radius.circular(10.0),
//                     topRight: Radius.circular(10.0),
//                   )),
//               width: 90,
//               height: 35,
//               child: Center(
//                 child: Text(
//                   selectedSportId == "0"
//                       ? activity.sportName
//                       : activity.lookingForValue,
//                   style: TextStyle(color: Colors.white, fontSize: 15.0),
//                 ),
//               ),
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   flex: 4,
//                   child: Container(
//                     margin: EdgeInsets.all(5.0),
// //                  padding: EdgeInsets.all(5.0),
//                     height: 85.0,
//                     width: 85.0,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10.0),
//                       child: Image.network(
//                         playerImage == null
//                             ? APIResources.AVATAR_IMAGE
//                             : APIResources.IMAGE_URL + playerImage,
//                         //fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 6,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 10.0),
//                       Text(
//                         activity.playerName,
//                         style: TextStyle(
//                           color: kBaseColor,
//                           fontSize: 16.0,
//                         ),
//                       ),
//                       SizedBox(height: 10.0),
//                       Text(
//                         "Looking For: ${activity.lookingFor}",
//                         style: TextStyle(
//                           color: Colors.grey.shade900,
//                           fontSize: 12.0,
//                         ),
//                       ),
//                       SizedBox(height: 5.0),
//                       Text(
//                         "Location: ${activity.area}",
//                         style: TextStyle(
//                           color: Colors.grey.shade900,
//                           fontSize: 12.0,
//                         ),
//                       ),
//                       SizedBox(height: 5.0),
//                       Text(
//                         "Time: ${activity.timing}",
//                         style: TextStyle(
//                           color: Colors.grey.shade900,
//                           fontSize: 12.0,
//                         ),
//                       ),
//                       SizedBox(height: 5.0),
//                       Text(
//                         "Date: ${activity.startDate}",
//                         style: TextStyle(
//                           color: Colors.grey.shade900,
//                           fontSize: 12.0,
//                         ),
//                       ),
//                       SizedBox(height: 5.0),
//                       Text(
//                         activity.ballType != null
//                             ? "Ball Type: ${activity.ballType} "
//                             : "",
//                         style: TextStyle(
//                           color: Colors.grey.shade900,
//                           fontSize: 12.0,
//                         ),
//                       ),
//                       SizedBox(height: 5.0),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  var playerId;
  var playerImage;
  var locationId;

  List<Activity>? activities;

  Future<List<Activity>?> getHostActivity() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      playerId = prefs.get("playerId");
      locationId = prefs.get("locationId");
      playerImage = prefs.get("playerImage");
      //locationId = "1";
      print("Player ID $playerId");
      HostActivity hostActivity =
          await apiCall.getHostActivity(locationId.toString(), selectedSportId);
      if (hostActivity.activites != null) {
        activities = hostActivity.activites!;

        activities = activities!.reversed.toList();
        //setState(() {});
      }
      if (hostActivity.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(hostActivity.message!);
      }
    } else {
      Utility.showToast("NO INTERNET CONNECTION");
    }

    return activities;
  }

  // Widget sportBar() {
  //   return Container(
  //     padding: EdgeInsets.all(5.0),
  //     child: FutureBuilder(
  //       future: getMySports(),
  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
  //         if (snapshot.data == null) {
  //           return Container(
  //             child: Center(
  //               child: Text('Loading....'),
  //             ),
  //           );
  //         }
  //         if (snapshot.hasData) {
  //           print("Has Data ${snapshot.data.length}");
  //           return Container(
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(10.0),
  //               border: Border.all(
  //                 width: 1.0,
  //                 color: Colors.grey,
  //               ),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black12,
  //                   offset: Offset(0, 2),
  //                   blurRadius: 6.0,
  //                 )
  //               ],
  //             ),
  //             height: 60,
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: snapshot.data.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return sportChip(snapshot.data[index]);
  //               },
  //             ),
  //           );
  //         } else {
  //           return Container(
  //             child: Center(
  //               child: Text('No Data'),
  //             ),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget sportBarList() {
    return sports != null
        ? Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                )
              ],
            ),
            height: 50,
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sports.length,
                itemBuilder: (BuildContext context, int index) {
                  return sportChip(sports[index]);
                },
              ),
            ),
          )
        : Container();
  }

  Widget sportChip(sport) {
    return GestureDetector(
      onTap: () {
        if (sport.sportId == null) {
          sports.removeLast();
          for (int i = 0; i < allSports.length; i++) {
            bool status = false;
            for (int j = 0; j < sports.length; j++) {
              // print("Checking for ${allSports[i].sportName}");
              if (allSports[i].sportName == sports[j].sportName) {
                status = false;
                // print("Found ${allSports[i].sportName}");
                break;
              } else {
                status = true;
                //  print("Not Found ${allSports[i].sportName}");
              }
            }
            if (status) {
              print("Sport Name ${allSports[i].sportName}");
              Sports s = new Sports();
              s.sportName = allSports[i].sportName;
              s.sportId = allSports[i].id.toString();
              sports.add(s);
            }
          }
        } else {
          selectedSportId = sport.sportId.toString();
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            width: 1.0,
            color: sport.sportId.toString() == selectedSportId
                ? kBaseColor
                : Colors.white,
          ),
          color: sport.sportId.toString() == selectedSportId
              ? kBaseColor
              : Colors.white,
        ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            sport.sportName,
            style: TextStyle(
                color: sport.sportId.toString() == selectedSportId
                    ? Colors.white
                    : Colors.black,
                fontSize: 12.0),
          ),
        ),
      ),
    );
  }

  var selectedSportId = "0";

  Future<List<Sports>> getMySports() async {
    APICall apiCall = new APICall();
    // List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      MySport mySport = await apiCall.getMySports(playerId.toString());

      if (mySport.sports != null) {
        Sports s = new Sports();
        s.sportName = "All";
        s.sportId = "0";
        sports.clear();
        sports.add(s);
        sports.addAll(mySport.sports!);
        Sports s2 = new Sports();
        s2.sportName = "Others";
        s2.sportId = null;
        sports.add(s2);
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
}
