import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/venue_data.dart';
import 'package:player/screens/add_venue.dart';
import 'package:player/screens/register_ground.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VenueScreen extends StatefulWidget {
  const VenueScreen({Key? key}) : super(key: key);

  @override
  _VenueScreenState createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
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
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddVenue()));
                    },
                    icon: Icon(
                      Icons.add,
                      color: kBaseColor,
                    ),
                    label: Text(
                      "Register",
                      style: TextStyle(color: kBaseColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              myVenue(),
            ],
          ),
        ),
      ),
    );
  }

  myVenue() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(20.0),
      child: FutureBuilder(
        future: getMyVenues(),
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
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 200),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return venueItem(snapshot.data[index]);
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
    );
  }

  List<Venue>? venues;

  Future<List<Venue>?> getMyVenues() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      VenueData venueData = await apiCall.getMyVenue(playerId.toString());
      if (venueData.venues != null) {
        venues = venueData.venues!;
        //setState(() {});
      }

      if (venueData.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(venueData.message!);
      }
    }
    return venues;
  }

  Widget venueItem(dynamic venue) {
    return GestureDetector(
      onTap: () {
        Utility.showToast(venue.name.toString());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
//      padding: EdgeInsets.only(bottom: 10.0),
        decoration: kContainerBoxDecoration,
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
                        fontSize: 20.0,
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
                    venue.address,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Hours: ${venue.openTime} to ${venue.closeTime}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Phone: ${venue.openTime}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 14.0,
                    ),
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
