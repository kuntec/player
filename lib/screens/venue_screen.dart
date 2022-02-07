import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/my_sport.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/model/venue_data.dart';
import 'package:player/venue/add_venue.dart';
import 'package:player/screens/register_ground.dart';
import 'package:player/venue/venue_details.dart';
import 'package:player/venue/venue_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VenueScreen extends StatefulWidget {
  const VenueScreen({Key? key}) : super(key: key);

  @override
  _VenueScreenState createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen>
    with AutomaticKeepAliveClientMixin<VenueScreen> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  int selectedIndex = 1;
  bool isMyVenue = false;
  List<Sports> sports = [];

  List<Data> allSports = [];

  var selectedSportId = "0";
  String searchString = "";
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMySports();
    getSports();
  }

  _refresh() {
    getMyVenues();
  }

  Future getMyVenues() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      VenueData venueData = await apiCall.getMyVenue(playerId.toString());
      if (venueData.venues != null) {}
      if (venueData.status!) {
        isMyVenue = true;
      } else {
        isMyVenue = false;
        print(venueData.message!);
      }
      if (venueData.status!) {
      } else {
        print(venueData.message!);
      }
    }
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
          title: Text("VENUES"),
          actions: [
            Container(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddVenue()));
                      _refresh();
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: kServiceBoxItem.copyWith(
                        color: kBaseColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(
                            isMyVenue ? Icons.person : Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(width: 5),
                          Text(
                            isMyVenue ? "My Venue" : "Register",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: sportBarList()),
              Expanded(flex: 8, child: allVenue()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshVenue(BuildContext context) async {
    setState(() {});
  }

  allVenue() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(10.0),
      child: RefreshIndicator(
        onRefresh: () => _refreshVenue(context),
        color: kBaseColor,
        child: FutureBuilder(
          future: getAllVenues(),
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
                  padding: EdgeInsets.only(bottom: 20),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return snapshot.data[index].name
                                .toString()
                                .toLowerCase()
                                .contains(searchString) ||
                            snapshot.data[index].address
                                .toString()
                                .toLowerCase()
                                .contains(searchString)
                        ? venueItem2(snapshot.data[index])
                        : SizedBox.shrink();
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

  List<Venue>? venues;

  Future<List<Venue>?> getAllVenues() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var locationId = prefs.getString("locationId").toString();
    if (connectivityStatus) {
      VenueData venueData =
          await apiCall.getVenue(locationId.toString(), selectedSportId);
      if (venueData.venues != null) {
        venues = venueData.venues!;
        venues = venues!.reversed.toList();
      }

      if (venueData.status!) {
      } else {
        print(venueData.message!);
      }
    } else {
      Utility.showToast("NO INTERNET CONNECTION");
    }
    return venues;
  }

  Widget venueItem2(dynamic venue) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VenueDetails(
                      venue: venue,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
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
                        APIResources.IMAGE_URL + venue.image,
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
                            venue.name,
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
                              venue.sport,
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
                    "Hours: ${venue.openTime} to ${venue.closeTime}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Address: ${venue.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Open Time: ${venue.openTime}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Close Time: ${venue.closeTime}",
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
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        margin: EdgeInsets.only(bottom: 10, right: 10),
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
                        child: Text(
                          "\u{20B9} ${venue.onwards} Onwards",
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

  Widget venueItem(dynamic venue) {
    return GestureDetector(
      onTap: () {
        //Utility.showToast("ID ${venue.id}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VenueDetails(
                      venue: venue,
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
                    // child: SvgPicture.network(
                    //   "https://www.svgrepo.com/show/2046/dog.svg",
                    //   placeholderBuilder: (context) =>
                    //       CircularProgressIndicator(),
                    //   height: 110.0,
                    //   width: 110,
                    //   fit: BoxFit.cover,
                    // ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        APIResources.IMAGE_URL + venue.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // children: [
                      //   SizedBox(width: 10.0),
                      //   Icon(
                      //     Icons.circle,
                      //     color: Colors.green,
                      //     size: 14.0,
                      //   ),
                      //   SizedBox(width: 10.0),
                      //   Text(
                      //     "2 hours ago",
                      //     style: TextStyle(fontSize: 12.0),
                      //   ),
                      // ],
                      ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 130.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    venue.name,
                    style: TextStyle(
                        color: kBaseColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SizedBox(width: 10.0),
                  //     Icon(
                  //       Icons.location_pin,
                  //       color: kBaseColor,
                  //       size: 14.0,
                  //     ),
                  //     SizedBox(width: 10.0),
                  //     Text(
                  //       "Saurashtra University, Munjka, Rajkot, Gujarat, 360005",
                  //       style: TextStyle(fontSize: 14.0),
                  //     ),
                  //   ],
                  // ),
                  Text(
                    "Address: ${venue.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Hours: ${venue.openTime} to ${venue.closeTime}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Phone: ${venue.openTime}",
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
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
                        child: Text(
                          "\u{20B9} ${venue.onwards} Onwards",
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
  //
  // Widget sportSelectBar(String title, bool status) {
  //   return Container(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         Text(
  //           title,
  //         ),
  //         if (status)
  //           SizedBox(
  //             height: 5.0,
  //             child: Container(
  //               height: 5.0,
  //               width: 10.0,
  //               color: kAppColor,
  //             ),
  //           )
  //       ],
  //     ),
  //   );
  // }

//   Widget venueItem() {
//     return Container(
//       margin: EdgeInsets.all(10.0),
// //      padding: EdgeInsets.only(bottom: 10.0),
//       decoration: kContainerBoxDecoration,
//       // height: 200,
//       child: Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(10.0),
//                   height: 110.0,
//                   width: 110.0,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(25.0),
//                     child: Image(
//                       image: AssetImage("assets/images/ground.jpg"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Row(
//                     // mainAxisAlignment: MainAxisAlignment.start,
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                     // children: [
//                     //   SizedBox(width: 10.0),
//                     //   Icon(
//                     //     Icons.circle,
//                     //     color: Colors.green,
//                     //     size: 14.0,
//                     //   ),
//                     //   SizedBox(width: 10.0),
//                     //   Text(
//                     //     "2 hours ago",
//                     //     style: TextStyle(fontSize: 12.0),
//                     //   ),
//                     // ],
//                     ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 130.0, right: 5.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10.0),
//                 Text(
//                   "Swami Vivekananda Indoor Stadium",
//                   style: TextStyle(
//                       color: kBaseColor,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10.0),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: [
//                 //     SizedBox(width: 10.0),
//                 //     Icon(
//                 //       Icons.location_pin,
//                 //       color: kBaseColor,
//                 //       size: 14.0,
//                 //     ),
//                 //     SizedBox(width: 10.0),
//                 //     Text(
//                 //       "Saurashtra University, Munjka, Rajkot, Gujarat, 360005",
//                 //       style: TextStyle(fontSize: 14.0),
//                 //     ),
//                 //   ],
//                 // ),
//                 Text(
//                   "Saurashtra University, Munjka, Rajkot, Gujarat, 360005",
//                   style: TextStyle(
//                     color: Colors.grey.shade900,
//                     fontSize: 14.0,
//                   ),
//                 ),
//                 SizedBox(height: 5.0),
//                 Text(
//                   "Hours: 9am to 10pm",
//                   style: TextStyle(
//                     color: Colors.grey.shade900,
//                     fontSize: 14.0,
//                   ),
//                 ),
//                 SizedBox(height: 5.0),
//                 Text(
//                   "Phone: 0280220000",
//                   style: TextStyle(
//                     color: Colors.grey.shade900,
//                     fontSize: 14.0,
//                   ),
//                 ),
//                 // Container(
//                 //   decoration: BoxDecoration(
//                 //       color: kBaseColor,
//                 //       borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                 //   width: 100,
//                 //   height: 40,
//                 //   child: Center(
//                 //     child: Text(
//                 //       "1000",
//                 //       style: TextStyle(color: Colors.white, fontSize: 16.0),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget activityItem(
//       String sport, String venue, String time, String endDate, String price) {
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
//                                 venue,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 18.0),
//                               ),
//                               SizedBox(height: 5),
//                               Text(
//                                 time,
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
