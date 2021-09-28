import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';

class MyGames extends StatefulWidget {
  const MyGames({Key? key}) : super(key: key);

  @override
  _MyGamesState createState() => _MyGamesState();
}

class _MyGamesState extends State<MyGames> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text("MY GAMES"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              activityItem(
                "CRICKET",
                "Sagar Shah",
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
                "Sagar Shah",
                "Looking For : Opponent Team",
                "Gotri",
                "12/11/2021",
                "8:00AM",
              ),
            ],
          ),
        ),
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
            margin: EdgeInsets.only(top: 15.0),
            alignment: Alignment.topRight,
            child: Icon(
              Icons.more_vert,
              color: Colors.white,
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
