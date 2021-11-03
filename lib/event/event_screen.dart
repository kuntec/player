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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getMyEvents();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [myEvent()],
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
                return eventItem(snapshot.data[index]);
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
      var locationId = "1";
      EventData eventData = await apiCall.getEvent(locationId.toString());
      if (eventData.events != null) {
        events = eventData.events!;
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
