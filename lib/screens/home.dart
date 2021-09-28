import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
//        backgroundColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: kAppColor,
        currentIndex: selectedIndex,
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
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            backgroundColor: kAppColor,
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              backgroundColor: kAppColor,
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              backgroundColor: kAppColor,
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              backgroundColor: kAppColor,
              label: "Home"),
        ],
      ),
      appBar: AppBar(
        leading: Icon(
          Icons.location_pin,
          color: Colors.white,
        ),
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          SizedBox(width: 10.0),
          Icon(
            Icons.message_outlined,
            color: Colors.white,
          ),
          SizedBox(width: 10.0),
        ],
        title: Text(
          "VADODARA",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                'assets/images/banner.jpg',
              ),
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(height: 10),
            buttonBar(),
            SizedBox(height: 10),
            sportBar(),
            SizedBox(height: 10),
            activityItem(
              "CRICKET",
              "Parth Agrawal",
              "Looking For : Opponent Team",
              "Vasna",
              "20/10/2021",
              "7:00AM",
            ),
            activityItem(
              "FOOTBALL",
              "Sagar Shah",
              "Looking For : Player to Join",
              "Waghodia",
              "10/10/2021",
              "8:00PM",
            ),
            activityItem(
              "VOLLEYBALL",
              "Smit Patel",
              "Looking For : Opponent Team",
              "Gotri",
              "12/11/2021",
              "8:00AM",
            ),
          ],
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

  Widget buttonBar() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: kContainerBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconCard(Icons.add, "Host Activity"),
          iconCard(Icons.people, "Friends"),
          iconCard(Icons.wine_bar, "Host Tournament"),
          iconCard(Icons.local_offer, "Offers"),
        ],
      ),
    );
  }

  Widget iconCard(IconData iconData, String title) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          SizedBox(height: 10.0),
          Text(title)
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
}
