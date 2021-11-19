import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/event/event_details.dart';
import 'package:player/event/event_register.dart';
import 'package:player/model/event_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool isEvent = false;
  String searchString = "";
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyEvents();
  }

  Future getMyEvents() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      EventData eventData = await apiCall.getMyEvent(playerId.toString());
      if (eventData.events != null) {
        if (eventData.events!.length == 0) {
          isEvent = false;
        } else {
          isEvent = true;
        }
      }

      if (eventData.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(eventData.message!);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("EVENTS"),
        actions: [
          Container(
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventRegister()));
                  },
                  icon: Icon(
                    isEvent ? Icons.star : Icons.add,
                    color: kBaseColor,
                  ),
                  label: Text(
                    isEvent ? "My Events" : "Register",
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: kServiceBoxItem,
              margin: EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchString = value;
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                    color: kBaseColor,
                  ),
                ),
              ),
            ),
            myEvent(),
          ],
        ),
      ),
    );
  }

  // Widget myEventList() {
  //   return Container(
  //     child: events != null
  //         ? ListView.builder(
  //             padding: EdgeInsets.only(bottom: 110),
  //             scrollDirection: Axis.vertical,
  //             shrinkWrap: true,
  //             itemCount: events!.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return eventItem(events![index]);
  //             },
  //           )
  //         : Center(child: Text("Loading")),
  //   );
  // }
  Widget myEvent() {
    return Container(
      height: 700,
      child: FutureBuilder(
        future: getEvents(),
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
              padding: EdgeInsets.only(bottom: 110),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                // return eventItem(snapshot.data[index]);
                return snapshot.data[index].name
                            .toString()
                            .toLowerCase()
                            .contains(searchString) ||
                        snapshot.data[index].address
                            .toString()
                            .toLowerCase()
                            .contains(searchString)
                    ? eventItem(snapshot.data[index])
                    : Container();
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

  List<Event>? events;

  Future<List<Event>?> getEvents() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var locationId = prefs.get("locationId");
      EventData eventData = await apiCall.getEvent(locationId.toString());
      if (eventData.events != null) {
        events = eventData.events!;

        events = events!.reversed.toList();
        //setState(() {});
      }

      if (eventData.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(eventData.message!);
      }
    }
    return events;
  }

  Widget eventItem(dynamic event) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventDetails(
                      event: event,
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
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
                        APIResources.IMAGE_URL + event.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Row(),
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
                    event.name,
                    style: TextStyle(
                        color: kBaseColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    event.address,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Start Date: ${event.startDate}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Location: ${event.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 14.0,
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
                          "\u{20B9} ${event.entryFees}",
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
}
