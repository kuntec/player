import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/host_activity.dart';
import 'package:player/screens/add_host_activity.dart';
import 'package:player/screens/choose_sport.dart';
import 'package:player/screens/location_select.dart';
import 'package:player/screens/player_profile.dart';
import 'package:player/screens/service_screen.dart';
import 'package:player/screens/sport_select.dart';
import 'package:player/screens/tournament_screen.dart';
import 'package:player/screens/venue_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int selectedIndex = 0;
  // final screens = [
  //   HomeScreen(),
  //   TournamentScreen(),
  //   VenueScreen(),
  //   ServiceScreen(),
  //   PlayerProfile()
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
// //        backgroundColor: Colors.grey,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         selectedItemColor: kAppColor,
//         currentIndex: selectedIndex,
//         onTap: (index) {
//           setState(() {
//             selectedIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//               color: kAppColor,
//             ),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.wine_bar),
//             backgroundColor: kAppColor,
//             label: "Tournament",
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.flag),
//               backgroundColor: kAppColor,
//               label: "Venue"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               backgroundColor: kAppColor,
//               label: "Service"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               backgroundColor: kAppColor,
//               label: "Profile"),
//         ],
//       ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LocationSelectScreen()));
          },
          child: Icon(
            Icons.location_pin,
            color: kBaseColor,
          ),
        ),
        actions: [
          Icon(
            Icons.notifications_active,
            color: Colors.black,
          ),
          SizedBox(width: 10.0),
          Icon(
            Icons.message,
            color: Colors.black,
          ),
          SizedBox(width: 10.0),
        ],
        title: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LocationSelectScreen()));
          },
          child: Text(
            "Vadodara",
            style: TextStyle(color: kBaseColor),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: AssetImage(
                    'assets/images/dream11.png',
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            buttonBar(),

            Container(
              height: 700,
              padding: EdgeInsets.all(20.0),
              child: FutureBuilder(
                future: getHostActivity(),
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
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: double.infinity),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return hostActivityItem(snapshot.data[index]);
                      },
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Text('No Data'),
                      ),
                    );
                  }
                },
              ),
            )

            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 20.0),
            //   height: 300,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       iconCard(Icons.add, "Host Activity"),
            //       iconCard(Icons.add, "Host Activity"),
            //       iconCard(Icons.add, "Host Activity"),
            //       iconCard(Icons.add, "Host Activity"),
            //       iconCard(Icons.add, "Host Activity"),
            //     ],
            //   ),
            // ),
            //stackExample(),
            // SizedBox(height: 10),
            // // buttonBar(),
            // SizedBox(height: 10),
            // sportBar(),
            // SizedBox(height: 10),
            //hostActivityItem(),
            // activityItem(
            //   "CRICKET",
            //   "Parth Agrawal",
            //   "Looking For : Opponent Team",
            //   "Vasna",
            //   "20/10/2021",
            //   "7:00AM",
            // ),
            // activityItem(
            //   "FOOTBALL",
            //   "Sagar Shah",
            //   "Looking For : Player to Join",
            //   "Waghodia",
            //   "10/10/2021",
            //   "8:00PM",
            // ),
            // activityItem(
            //   "VOLLEYBALL",
            //   "Smit Patel",
            //   "Looking For : Opponent Team",
            //   "Gotri",
            //   "12/11/2021",
            //   "8:00AM",
            // ),
          ],
        ),
      ),
    );
  }

  Widget sportBar() {
    return Container(
      margin: EdgeInsets.all(10.0),
      //padding: EdgeInsets.all(10.0),
//      height: 20.0,
      decoration: kContainerBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          sportSelectBar("All", true, () {
            print("All selected");
          }),
          sportSelectBar("Cricket", false, () {
            print("Cricket selected");
          }),
          sportSelectBar("Football", false, () {
            print("Football selected");
          }),
          sportSelectBar("Others +", false, () {
            print("Other selected");
          }),
        ],
      ),
    );
  }

  Widget buttonBar() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: kContainerBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconCard(Icons.add, "Host Activity", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddHost()));
          }),
          iconCard(Icons.people, "Friends", () {}),
          iconCard(Icons.wine_bar, "Host Tournament", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChooseSport()));
          }),
          iconCard(Icons.local_offer, "Offers", () {}),
        ],
      ),
    );
  }

  Widget iconCard(IconData iconData, String title, dynamic onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              iconData,
              color: Colors.black,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }

  Widget sportSelectBar(String title, bool status, dynamic onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 70.0,
        height: 40.0,
        decoration: kContainerChipBoxDecoration.copyWith(
            color: status ? kBaseColor : Colors.white),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: status ? Colors.white : Colors.black),
        )),
      ),
    );
  }

  Widget stackExample(dynamic data) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.only(bottom: 10.0),
      decoration: kContainerBoxDecoration,
      // height: 200,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  height: 85.0,
                  width: 85.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image(
                      image: AssetImage("assets/images/demo.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 10.0),
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 14.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "2 hours ago",
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Text(
                  "Tausif Saiyed",
                  style: TextStyle(
                    color: kBaseColor,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Looking For: A Player To Join My Team",
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Location: Vasna",
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Time: 6:30 PM",
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Date: 06-11-2021",
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 14.0,
                  ),
                ),
//                Row(),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: kBaseColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                )),
            width: 100,
            height: 40,
            child: Center(
              child: Text(
                "Cricket",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget hostActivityItem() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //     decoration: kContainerBoxDecoration,
  //     child: Stack(
  //       children: [
  //         Container(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Column(
  //                 children: [
  //                   Container(
  //                     margin: EdgeInsets.all(10.0),
  //                     height: 85.0,
  //                     width: 85.0,
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(25.0),
  //                       child: Image(
  //                         image: AssetImage("assets/images/demo.jpg"),
  //                       ),
  //                     ),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Icon(
  //                         Icons.circle,
  //                         color: Colors.green,
  //                         size: 14.0,
  //                       ),
  //                       SizedBox(width: 10.0),
  //                       Text(
  //                         "2 hours ago",
  //                         style: TextStyle(fontSize: 12.0),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Text(
  //                         "Tausif Saiyed",
  //                         style: TextStyle(
  //                           color: kBaseColor,
  //                           fontSize: 18.0,
  //                         ),
  //                       ),
  //                       Container(
  //                         height: 40.0,
  //                         width: 100.0,
  //                         color: kBaseColor,
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: 10.0),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: Text(
  //                           "Looking For: A Player To Join My Team ",
  //                           style: TextStyle(
  //                             color: Colors.grey.shade900,
  //                             fontSize: 14.0,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: 5.0),
  //                   Text(
  //                     "Location: Vasna",
  //                     style: TextStyle(
  //                       color: Colors.grey.shade900,
  //                       fontSize: 14.0,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5.0),
  //                   Text(
  //                     "Time: 6:30 PM",
  //                     style: TextStyle(
  //                       color: Colors.grey.shade900,
  //                       fontSize: 14.0,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5.0),
  //                   Text(
  //                     "Date: 06-11-2021",
  //                     style: TextStyle(
  //                       color: Colors.grey.shade900,
  //                       fontSize: 14.0,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5.0),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget activityItem(String sport, String name, String looking, String area,
      String date, String time) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
//      decoration: kContainerBoxDecoration,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: kAppColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 100.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text(
                              looking,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Area",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                              Text(
                                area,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Date",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                              Text(
                                date,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Time",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                              Text(
                                time,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, top: 50.0),
            height: 50.0,
            width: 50.0,
            child: Image(
              image: AssetImage("assets/images/avatar.png"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0),
//            padding: EdgeInsets.all(2.0),
            height: 30.0,
            width: 90.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage("assets/images/banner.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                sport,
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  hostActivityItem(dynamic activity) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: kContainerBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  height: 90.0,
                  width: 90.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.network(
                        APIResources.IMAGE_URL + playerImage,
                      )),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Text(
                      activity.playerName,
                      style: TextStyle(
                        color: kBaseColor,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Looking For: ${activity.lookingFor}",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Location: ${activity.area}",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Time: ${activity.timing}",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Date: ${activity.startDate}",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      activity.ballType != null
                          ? "Ball Type: ${activity.ballType} "
                          : "",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     child: Icon(
              //       Icons.more_horiz,
              //       color: kBaseColor,
              //       size: 20.0,
              //     ),
              //   ),
              // ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: kBaseColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                )),
            width: 100,
            height: 35,
            child: Center(
              child: Text(
                activity.sportName,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  var playerId;
  var playerImage;
  var locationId;

  List<Activites>? activities;

  Future<List<Activites>?> getHostActivity() async {
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
          await apiCall.getHostActivity(locationId.toString());
      if (hostActivity.activites != null) {
        activities = hostActivity.activites!;
        //setState(() {});
      }
      if (hostActivity.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(hostActivity.message!);
      }
    }
    return activities;
  }
}
