import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/my_sport.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/model/tournament_data.dart';
import 'package:player/screens/tournament_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({Key? key}) : super(key: key);

  @override
  _TournamentScreenState createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  int selectedIndex = 1;
  List<Sports> sports = [];

  List<Data> allSports = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMySports();
    getSports();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           currentIndex: selectedIndex,
//           selectedItemColor: kAppColor,
// //        backgroundColor: Colors.grey,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           unselectedItemColor: Colors.black38,
//           onTap: (index) {
//             setState(() {
//               selectedIndex = index;
//             });
//           },
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.home,
//                 color: kAppColor,
//               ),
//               label: "",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.wine_bar),
//               backgroundColor: kAppColor,
//               label: "",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.flag),
//               backgroundColor: kAppColor,
//               label: "",
//             ),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.settings),
//                 backgroundColor: kAppColor,
//                 label: ""),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 backgroundColor: kAppColor,
//                 label: "Home"),
//           ],
//         ),
        appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
          title: Text("TOURNAMENTS"),
          // actions: [
          //   Container(
          //     margin: EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15.0),
          //       color: Colors.white,
          //     ),
          //     width: 100,
          //     height: 300,
          //     child: Center(
          //       child: Text(
          //         "My Games",
          //         style: TextStyle(color: kAppColor, fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image(
              //   image: AssetImage(
              //     'assets/images/banner.jpg',
              //   ),
              //   width: MediaQuery.of(context).size.width,
              // ),
              SizedBox(height: 10),
              //buttonBar(),
              //sportBar(),
              sportBarList(),
              allTournaments(),
              SizedBox(height: 10),

              // Expanded(flex: 1, child: sportBar()),
              // SizedBox(height: 10),
              // Expanded(
              //   flex: 1,
              //   child: allTournaments(),
              // ),

              // activityItem(
              //   "CRICKET",
              //   "Player Premier League",
              //   "Start Date : 20/10/2021",
              //   "",
              //   "Rs. 500",
              // ),
              // activityItem(
              //   "FOOTBAL",
              //   "Football Premier League",
              //   "Start Date : 06/11/2021",
              //   "End Date : 15/11/2021",
              //   "Rs. 1250",
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
      ),
    );
  }

  Widget allTournaments() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 100),
      child: FutureBuilder(
        future: getTournaments(),
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
                  child: Text('No Data'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 150),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return tournamentItem2(snapshot.data[index]);
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

  List<Tournament>? tournaments;

  Future<List<Tournament>?> getTournaments() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");
      var locationId = prefs.get("locationId");
      TournamentData tournamentData =
          await apiCall.getTournament(locationId.toString(), selectedSportId);
      if (tournamentData.tournaments != null) {
        tournaments = tournamentData.tournaments!;
        tournaments = tournaments!.reversed.toList();
        //setState(() {});
      }

      if (tournamentData.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(tournamentData.message!);
      }
    } else {
      Utility.showToast("NO INTERNET CONNECTION");
    }
    return tournaments;
  }

  Widget tournamentItem2(dynamic tournament) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TournamentDetails(
                      tournament: tournament,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
//      padding: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
        // height: 200,
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    height: 110.0,
                    width: 110.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        APIResources.IMAGE_URL + tournament.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 130.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          height: 20,
                          child: Text(
                            tournament.tournamentName,
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
                              tournament.sportName,
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
                    "Start Date: ${tournament.startDate}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Start Time: ${tournament.startTime}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "End Time: ${tournament.endTime}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Location: ${tournament.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: kServiceBoxItem.copyWith(
                            color: kBaseColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            )),
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
                        child: Text(
                          "\u{20B9}  ${tournament.entryFees}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget tournamentItem(dynamic tournament) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => TournamentDetails(
  //                     tournament: tournament,
  //                   )));
  //     },
  //     child: Container(
  //       margin: EdgeInsets.all(10.0),
  //       decoration: kContainerBoxDecoration,
  //       // height: 150,
  //       child: Stack(
  //         alignment: Alignment.bottomRight,
  //         children: [
  //           Container(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 ClipRRect(
  //                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                   child: Image.network(
  //                     APIResources.IMAGE_URL + tournament.image,
  //                     fit: BoxFit.fill,
  //                   ),
  //                 ),
  //                 SizedBox(height: 20),
  //                 Container(
  //                   margin: EdgeInsets.only(left: 10.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         tournament.tournamentName,
  //                         style: TextStyle(color: kBaseColor, fontSize: 18.0),
  //                       ),
  //                       SizedBox(height: 5),
  //                       Text(
  //                         "Start Date : ${tournament.startDate}",
  //                         style: TextStyle(color: Colors.black, fontSize: 14.0),
  //                       ),
  //                       SizedBox(height: 5),
  //                       Text(
  //                         "Location : ${tournament.address}",
  //                         style: TextStyle(color: Colors.black, fontSize: 14.0),
  //                       ),
  //                       SizedBox(height: 10),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 50,
  //             right: 20,
  //             child: Container(
  //               child: Text(
  //                 tournament.prizeDetails,
  //                 style: TextStyle(color: kBaseColor, fontSize: 18.0),
  //               ),
  //             ),
  //           ),
  //           Container(
  //             decoration: BoxDecoration(
  //                 color: kBaseColor,
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(15.0),
  //                   bottomRight: Radius.circular(15.0),
  //                 )),
  //             width: 100,
  //             height: 40,
  //             child: Center(
  //               child: Text(
  //                 tournament.sportName,
  //                 style: TextStyle(color: Colors.white, fontSize: 16.0),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget sportBar() {
  //   return Container(
  //     margin: EdgeInsets.all(10.0),
  //     padding: EdgeInsets.all(10.0),
  //     decoration: kContainerBoxDecoration,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         sportSelectBar("All", true),
  //         sportSelectBar("Cricket", false),
  //         sportSelectBar("Football", false),
  //         sportSelectBar("Others +", false),
  //       ],
  //     ),
  //   );
  // }

  // Widget sportBar() {
  //   // return Container(
  //   //   height: 100,
  //   //   child: ListView.builder(
  //   //     scrollDirection: Axis.horizontal,
  //   //     itemCount: 10,
  //   //     itemBuilder: (BuildContext context, int index) => Container(
  //   //       height: 50,
  //   //       width: 50,
  //   //       child: sportChip(sports[0]),
  //   //     ),
  //   //   ),
  //   // );
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
  //             decoration: kContainerBox,
  //             height: 70,
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: snapshot.data.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return sportChip(snapshot.data[index]);
  //               },
  //             ),
  //           );
  //           // return ListView.builder(
  //           //   scrollDirection: Axis.horizontal,
  //           //   itemCount: snapshot.data.length,
  //           //   itemBuilder: (BuildContext context, int index) {
  //           //     return sportChip(snapshot.data[index]);
  //           //   },
  //           // );
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
  //
  // Widget sportChip(sport) {
  //   return GestureDetector(
  //     onTap: () {
  //       print("Selected sport ${sport.sportId} ${sport.sportName} ");
  //       selectedSportId = sport.sportId.toString();
  //       setState(() {});
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         border: Border.all(
  //           width: 1.0,
  //           color: sport.sportId.toString() == selectedSportId
  //               ? kBaseColor
  //               : Colors.white,
  //         ),
  //         color: sport.sportId.toString() == selectedSportId
  //             ? kBaseColor
  //             : Colors.white,
  //       ),
  //       margin: EdgeInsets.all(10.0),
  //       padding: EdgeInsets.all(10.0),
  //
  //       child: Center(
  //         child: Text(
  //           sport.sportName,
  //           style: TextStyle(
  //               color: sport.sportId.toString() == selectedSportId
  //                   ? Colors.white
  //                   : Colors.black,
  //               fontSize: 14.0),
  //         ),
  //       ),
  //       // margin: EdgeInsets.all(10.0),
  //       // child: Center(
  //       //   child: Chip(
  //       //     label: Center(
  //       //       child: Text(
  //       //         sport.sportName,
  //       //         style: TextStyle(color: Colors.white),
  //       //       ),
  //       //     ),
  //       //     backgroundColor: kBaseColor,
  //       //     elevation: 6.0,
  //       //   ),
  //       // ),
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

  // Widget sportSelectBar(String title, bool status) {
  //   return GestureDetector(
  //     onTap: () {
  //       print("Clicked $title");
  //       selectedSportId = "6";
  //     },
  //     child: Container(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Text(
  //             title,
  //           ),
  //           if (status)
  //             SizedBox(
  //               height: 5.0,
  //               child: Container(
  //                 height: 5.0,
  //                 width: 10.0,
  //                 color: kAppColor,
  //               ),
  //             )
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
//
//   Widget activityItem(String sport, String tournament, String startDate,
//       String endDate, String price) {
//     return Container(
//       margin: EdgeInsets.all(5.0),
//       padding: EdgeInsets.all(5.0),
// //      decoration: kContainerBoxDecoration,
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(0),
//                 margin: EdgeInsets.only(top: 10.0),
//                 decoration: BoxDecoration(
//                   color: kAppColor,
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       // height: 50.0,
//                       // width: 50.0,
//                       child: Image(
//                         image: AssetImage("assets/images/ground.jpg"),
//                       ),
//                     ),
//                     // Container(
//                     //   margin: EdgeInsets.only(left: 100.0),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       Text(
//                     //         name,
//                     //         style:
//                     //             TextStyle(color: Colors.white, fontSize: 18.0),
//                     //       ),
//                     //       ListTile(
//                     //         contentPadding: EdgeInsets.all(0),
//                     //         title: Text(
//                     //           looking,
//                     //           style: TextStyle(
//                     //               color: Colors.white, fontSize: 14.0),
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 tournament,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 18.0),
//                               ),
//                               SizedBox(height: 5),
//                               Text(
//                                 startDate,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 14.0),
//                               ),
//                               SizedBox(height: 5),
//                               Text(
//                                 endDate,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 14.0),
//                               ),
//                               SizedBox(height: 5),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             children: [
//                               Text(
//                                 price,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 20.0),
//                               ),
//                               SizedBox(height: 10.0),
//                               Container(
//                                 alignment: Alignment.bottomRight,
//                                 margin: EdgeInsets.only(right: 5.0),
//                                 child: Text(
//                                   "tap for details",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 10.0),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 15.0),
// //            padding: EdgeInsets.all(2.0),
//             height: 30.0,
//             width: 90.0,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               image: DecorationImage(
//                 image: AssetImage("assets/images/banner.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 sport,
//                 style: TextStyle(color: Colors.white, fontSize: 14.0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}
