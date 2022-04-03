import 'dart:io';

import 'package:badges/badges.dart';
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
import 'package:player/constant/dialogbuilder.dart';
import 'package:player/constant/firestore_constants.dart';
import 'package:player/constant/time_ago.dart';
import 'package:player/constant/utility.dart';
import 'package:player/event/event_screen.dart';
import 'package:player/friends/chat_screen.dart';
import 'package:player/friends/friend.dart';
import 'package:player/model/banner_data.dart';
import 'package:player/model/conversation_data.dart';
import 'package:player/model/host_activity.dart';
import 'package:player/model/my_sport.dart';
import 'package:player/model/player_data.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/model/unread_notification_data.dart';
import 'package:player/providers/banner_model.dart';
import 'package:player/screens/add_host_activity.dart';
import 'package:player/screens/add_tournament.dart';
import 'package:player/screens/booking_confirmation.dart';
import 'package:player/screens/choose_sport.dart';
import 'package:player/screens/location_select.dart';
import 'package:player/screens/main_navigation.dart';
import 'package:player/screens/notification_screen.dart';
import 'package:player/screens/offer_screen.dart';
import 'package:player/service/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  bool keepAlive = false;

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;

  @override
  bool get wantKeepAlive => true;
  List<Sports> sports = [];
  List<Data> allSports = [];
  List<Banners> banners = [];
  List<Conversation> conversations = [];
  List<Unread> unread = [];
  var city;
  int? _chatCount = 0;
  int? _notificationCount = 0;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late HomeProvider homeProvider;
//  late String currentUserId;

  Future disposePageAfter(int time) async {
    keepAlive = true;
    updateKeepAlive();
    await Future.delayed(Duration(seconds: time));
    keepAlive = false;
    updateKeepAlive();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeProvider = context.read<HomeProvider>();

    final bannerMdl = Provider.of<BannerModel>(context, listen: false);
    bannerMdl.getBannerData(context);

    getMyProfile();
    //getBanner();
    getMySports();
    getSports();
    getMyCity();
    getConversations();
    getUnreadNotifications();
    getHostActivity();
    disposePageAfter(20);

    FirebaseMessaging.onMessage.listen((message) {
      // if (Platform.isIOS) {
      //   message = _modifyNotificationJSON(message);
      // }
      if (message.notification != null) {
        //_notificationCount = _notificationCount! + 1;

        // print(message.notification!.body);
        print("Data Title ${message.data['title']}");
        if (message.data['title'] == "1") {
          getUnreadNotifications();
        } else {
          getConversations();
        }
      }
      LocalNotificationService.display(message);
    });

    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  // Map _modifyNotificationJSON(Map<String, dynamic> message) {
  //   message['data'] = Map.from(message ?? {});
  //   return message;
  // }

  Future<List<Unread>> getUnreadNotifications() async {
    APICall apiCall = new APICall();

    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? playerId = prefs.getInt("playerId");
      print("Player id $playerId");
      UnreadNotificationData unreadNotificationData =
          await apiCall.getUnreadNotifications(playerId.toString());
      if (unreadNotificationData.unread != null) {
        unread = unreadNotificationData.unread!;
        // conversations = conversations.reversed.toList();
        print("this is chat count before $_notificationCount");
        _notificationCount = unread.length;
        print("this is chat count after $_chatCount");
        setState(() {});
      }
    }
    return unread;
  }

  Future<List<Conversation>> getConversations() async {
    APICall apiCall = new APICall();

    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? playerId = prefs.getInt("playerId");
      print("Player id $playerId");
      ConversationData conversationData =
          await apiCall.getMyConversation(playerId.toString());
      if (conversationData.conversation != null) {
        conversations = conversationData.conversation!;
        // conversations = conversations.reversed.toList();
        _chatCount = 0;
        print("this is chat count before $_chatCount");
        for (Conversation c in conversations) {
          for (Reply r in c.reply!) {
            // print("Reply Status : {$r.status}");
            if (r.status == "0" &&
                r.playerId.toString() != playerId.toString()) {
              _chatCount = _chatCount! + 1;
            }
          }
        }
        print("this is chat count after $_chatCount");
        setState(() {});
      }
    }
    return conversations;
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

  Future<void> _refreshActivities(BuildContext context) async {
//    setState(() {});
    getHostActivity();
  }

  @override
  Widget build(BuildContext context) {
    final bannerMdl = Provider.of<BannerModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () async {
              setState(() {
                _notificationCount = 0;
              });
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
              getUnreadNotifications();
            },
            child: _notificationCount == 0
                ? Icon(
                    Icons.notifications_active,
                    color: Colors.black,
                  )
                : Badge(
                    position: BadgePosition.topStart(top: 5, start: 15),
                    badgeContent: Text(
                      '$_notificationCount',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.black,
                    ),
                  ),
          ),
          SizedBox(width: 20.0),
          GestureDetector(
            onTap: () async {
              //DialogBuilder(context).showLoadingIndicator('Calculating + 1');
              // await _incrementCounter();
              //DialogBuilder(context).hideOpenDialog();
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            isFriend: false,
                          )));
              getConversations();
            },
            child: _chatCount == 0
                ? Icon(
                    Icons.message,
                    color: Colors.black,
                  )
                : Badge(
                    position: BadgePosition.topStart(top: 5, start: 15),
                    badgeContent: Text(
                      '$_chatCount',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.message,
                      color: Colors.black,
                    ),
                  ),
          ),
          SizedBox(width: 20.0),
        ],
        title: GestureDetector(
          onTap: () async {
            var result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LocationSelectScreen(player: player)));
            if (result == null) {
//              Utility.showToast("No Refresh");
            } else {
              if (result) {
//                Utility.showToast("Refresh");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MainNavigation(
                              selectedIndex: 0,
                            )));
                //getMyCity();
              }
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
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: closeTopContainer ? 0 : 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer
                    ? 0
                    : MediaQuery.of(context).size.width * 0.30,
                child: bannerMdl.loading == true
                    ? CircularProgressIndicator(
                        color: kBaseColor,
                      )
                    : banner(bannerMdl),
              ),
            ),
            SizedBox(height: 10),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: closeTopContainer ? 0 : 1,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                  height: closeTopContainer
                      ? 0
                      : MediaQuery.of(context).size.width * 0.30,
                  child: homeButtonBar()),
            ),
            SizedBox(height: 10),
            sportBarList(),
            Expanded(
              child:
                  // activities!.length == 0
                  //     ? Container(
                  //         child: Text("No Data"),
                  //       )
                  //     :
                  Container(
                padding: EdgeInsets.all(10.0),
                child: RefreshIndicator(
                  onRefresh: () => _refreshActivities(context),
                  color: kBaseColor,
                  child: activities == null
                      ? SizedBox.shrink()
                      : activities!.length == 0
                          ? Container(
                              child: Center(
                                child: Text('No Data'),
                              ),
                            )
                          : ListView.builder(
                              controller: controller,
                              itemCount: activities!.length,
                              itemBuilder: (context, index) {
                                return hostActivityItem2(activities![index]);
                              }),
                ),
              ),
            )
            // hostActivity()
          ],
        ),
      ),
    );
  }

  Widget banner(dynamic bannerMdl) {
    return bannerMdl.bannerData == null
        ? SizedBox.shrink()
        : bannerMdl.bannerData.banners.length == 0
            ? SizedBox.shrink()
            : Container(
                margin: EdgeInsets.all(5),
                child: CarouselSlider.builder(
                    itemCount: bannerMdl.bannerData.banners.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage =
                          bannerMdl.bannerData.banners[index].imgUrl.toString();
                      return buildImage(urlImage, index);
                    },
                    options: CarouselOptions(
                        //viewportFraction: 1,
                        //enlargeCenterPage: true,
                        height: 110,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3))),
              );
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
      child: RefreshIndicator(
        onRefresh: () => _refreshActivities(context),
        color: kBaseColor,
        child: FutureBuilder(
          future: getHostActivity(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Container(
                    child: CircularProgressIndicator(color: kBaseColor)),
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
                  controller: controller,
                  padding: EdgeInsets.only(bottom: 20),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
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
              //setState(() {});
              _refreshActivities(context);
            }
          }, false, ""),
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
          }, false, ""),
          iconCard(Container(), "Host Tournament", 3, tournamentEndColor,
              () async {
            var result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTournament()));
            //do something here. Go to Tournament from here.
//            Utility.showToast("Returning from Tournament");
            //Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => MainNavigation(
                          selectedIndex: 1,
                        )));
          }, true, "tournament.svg"),
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
          }, false, ""),
          iconCard(Container(), "Offers", 5, offerEndColor, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OfferScreen()));
          }, true, "offer.svg"),
        ],
      ),
    );
  }

  Widget iconCard(Widget iconData, String title, int index, Color endColor,
      dynamic onPress, bool isTournament, String svgName) {
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
                          "assets/images/${svgName}",
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

  var currentConversationId;
  hostActivityItem2(dynamic activity) {
    return GestureDetector(
      onTap: () {
        //Utility.showToast("Activity To Chat ${activity.playerImage}");
        if (playerId.toString() == activity.playerId.toString()) {
          Utility.showToast("This is your Host Activity");
        } else {
          for (Conversation c in conversations) {
            // Utility.showToast("Conversation ID  ${c.id}");
            if (c.player1!.id.toString() == playerId.toString() &&
                c.player2!.id.toString() == activity.playerId) {
              //  Utility.showToast("Conversation ID  ${c.id}");
              currentConversationId = c.id;
            }

            if (c.player2!.id.toString() == playerId.toString() &&
                c.player1!.id.toString() == activity.playerId) {
              //  Utility.showToast("Conversation ID  ${c.id}");
              currentConversationId = c.id;
            }
          }

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                      conversationId: currentConversationId.toString(),
                      player1: playerId.toString(),
                      player2: activity.playerId.toString(),
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
                  activity.ballType != null
                      ? SizedBox(height: 5.0)
                      : SizedBox.shrink(),
                  activity.ballType != null
                      ? Text(
                          "Ball Type: ${activity.ballType}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 5.0),
                  activity.roleOfPlayer != null
                      ? Text(
                          "Role of Player: ${activity.roleOfPlayer}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.only(right: 7, bottom: 2),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Tap To Chat",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 10.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  var playerId;
  var playerImage;
  var locationId;

  List<Activity>? activities;

  Future<List<Activity>?> getHostActivity() async {
    // Utility.showToast("Getting Host Activity");
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
        setState(() {});
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
        getHostActivity();
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

  Player? player;
  getMyProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var playerId = prefs.get("playerId");
    var playerName = prefs.get("playerName");
    var mobile = prefs.get("mobile");
    //Utility.showToast("Player ${playerId} mobile ${mobile}");
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      print("Player " + mobile.toString());
//    showToast("Player " + phoneNumber);
      PlayerData playerData = await apiCall.checkPlayer(mobile.toString());

      if (playerData.status!) {
        setState(() {
          player = playerData.player;
        });

//        getLocation();
        //  Utility.showToast("Player Found ${playerData.player!.image}");
      }
    }
  }
}
