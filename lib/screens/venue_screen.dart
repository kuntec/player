import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';

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
              SizedBox(height: 10),
              sportBar(),
              SizedBox(height: 10),
              venueItem(),
              activityItem(
                "CRICKET",
                "The Turf",
                "Timing: 6:00AM to 8:00AM",
                "Vasna",
                "Rs. 200 / hr",
              ),
              activityItem(
                "FOOTBAL",
                "Courtyard",
                "Timing: 7:00PM to 9:P0AM",
                "Gotri",
                "Rs. 1000",
              ),
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

  Widget sportBar() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: kContainerBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          sportSelectBar("All", true),
          sportSelectBar("Cricket", false),
          sportSelectBar("Football", false),
          sportSelectBar("Others +", false),
        ],
      ),
    );
  }

  Widget sportSelectBar(String title, bool status) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
          ),
          if (status)
            SizedBox(
              height: 5.0,
              child: Container(
                height: 5.0,
                width: 10.0,
                color: kAppColor,
              ),
            )
        ],
      ),
    );
  }

  Widget venueItem() {
    return Container(
      margin: EdgeInsets.all(10.0),
//      padding: EdgeInsets.only(bottom: 10.0),
      decoration: kContainerBoxDecoration,
      // height: 200,
      child: Stack(
        alignment: Alignment.bottomRight,
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
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image(
                      image: AssetImage("assets/images/ground.jpg"),
                      fit: BoxFit.cover,
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
                  "Swami Vivekananda Indoor Stadium",
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
                  "Saurashtra University, Munjka, Rajkot, Gujarat, 360005",
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Hours: 9am to 10pm",
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Phone: 0280220000",
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
    );
  }

  Widget activityItem(
      String sport, String venue, String time, String endDate, String price) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
//      decoration: kContainerBoxDecoration,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: kAppColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // height: 50.0,
                      // width: 50.0,
                      child: Image(
                        image: AssetImage("assets/images/ground.jpg"),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 100.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         name,
                    //         style:
                    //             TextStyle(color: Colors.white, fontSize: 18.0),
                    //       ),
                    //       ListTile(
                    //         contentPadding: EdgeInsets.all(0),
                    //         title: Text(
                    //           looking,
                    //           style: TextStyle(
                    //               color: Colors.white, fontSize: 14.0),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                venue,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              SizedBox(height: 5),
                              Text(
                                time,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                              SizedBox(height: 5),
                              Text(
                                endDate,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                price,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.bottomRight,
                                margin: EdgeInsets.only(right: 5.0),
                                child: Text(
                                  "tap for details",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10.0),
                                ),
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
}
