import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({Key? key}) : super(key: key);

  @override
  _TournamentScreenState createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: kAppColor,
//        backgroundColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.black38,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: kAppColor,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wine_bar),
              backgroundColor: kAppColor,
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              backgroundColor: kAppColor,
              label: "",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                backgroundColor: kAppColor,
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                backgroundColor: kAppColor,
                label: "Home"),
          ],
        ),
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
              SizedBox(height: 10),
              sportBar(),
              SizedBox(height: 10),
              activityItem(
                "CRICKET",
                "Player Premier League",
                "Start Date : 20/10/2021",
                "",
                "Rs. 500",
              ),
              activityItem(
                "FOOTBAL",
                "Football Premier League",
                "Start Date : 06/11/2021",
                "End Date : 15/11/2021",
                "Rs. 1250",
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

  Widget activityItem(String sport, String tournament, String startDate,
      String endDate, String price) {
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
                                tournament,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              SizedBox(height: 5),
                              Text(
                                startDate,
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
