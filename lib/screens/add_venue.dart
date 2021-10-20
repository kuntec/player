import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/venue_data.dart';
import 'package:player/screens/add_venue_details.dart';
import 'package:player/screens/add_venue_slot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddVenue extends StatefulWidget {
  const AddVenue({Key? key}) : super(key: key);

  @override
  _AddVenueState createState() => _AddVenueState();
}

class _AddVenueState extends State<AddVenue> {
  bool? isMyVenueSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Venue")),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBaseColor,
            )),
      ),
      // bottomSheet: Container(
      //   margin: EdgeInsets.all(k20Margin),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       FloatingActionButton(
      //         backgroundColor: kBaseColor,
      //         onPressed: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => AddVenueDetails(
      //                         isEdit: false,
      //                       )));
      //         },
      //         child: Icon(Icons.add),
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddVenueDetails(
                        isEdit: false,
                      )));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: kBaseColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: k20Margin),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMyVenueSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabLeftDecoration.copyWith(
                            color:
                                isMyVenueSelected! ? Colors.white : kBaseColor),
                        child: Center(
                          child: Text(
                            "My Venue",
                            style: TextStyle(
                                color: isMyVenueSelected!
                                    ? kBaseColor
                                    : Colors.white,
                                fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMyVenueSelected = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabRightDecoration.copyWith(
                            color:
                                isMyVenueSelected! ? kBaseColor : Colors.white),
                        child: Center(
                          child: Text(
                            "Booking",
                            style: TextStyle(
                                color: isMyVenueSelected!
                                    ? Colors.white
                                    : kBaseColor,
                                fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isMyVenueSelected! ? booking() : myVenue(),
          ],
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
            // return Container(
            //   child: Center(
            //     child: Text('Yes Data ${snapshot.data}'),
            //   ),
            // );
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 210),
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
//        Utility.showToast(venue.name.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddVenueSlot(
                      venue: venue,
                    )));
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
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: kBaseColor,
                  //       borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  //   width: 100,
                  //   height: 40,
                  //   child: Center(
                  //     child: Text(
                  //       "1000",
                  //       style: TextStyle(color: Colors.white, fontSize: 16.0),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  booking() {
    return Container(
      child: Text("Booking"),
    );
  }
}
