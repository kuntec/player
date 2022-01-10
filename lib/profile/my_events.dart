import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/custom_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/event_data.dart';
import 'package:player/model/my_participant_data.dart';
import 'package:player/model/participant_data.dart';
import 'package:player/screens/tournament_participants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyEvents extends StatefulWidget {
  dynamic player;
  MyEvents({this.player});

  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Events"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            myEvent(),
          ],
        ),
      ),
    );
  }

  Widget myEvent() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(5.0),
      child: FutureBuilder(
        future: getMyEvents(),
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
                  child: Text('No Events'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 110),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return eventItem(snapshot.data[index]);
                },
              );
            }
          } else {
            return Container(
              child: Center(
                child: Text('No Events'),
              ),
            );
          }
        },
      ),
    );
  }

  List<Participants>? participants;

  Future<List<Participants>?> getMyEvents() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      MyParticipantData myParticipantData =
          await apiCall.getEventParticipant(playerId.toString());
      if (myParticipantData.participants != null) {
        participants = myParticipantData.participants!;
        participants = participants!.reversed.toList();
        //setState(() {});
      }

      if (myParticipantData.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(myParticipantData.message!);
      }
    }
    return participants;
  }

  Future<void> updateParticipant(participant) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      ParticipantData participantData =
          await apiCall.updateParticipant(participant);
      if (participantData.participants != null) {
        //Utility.showToast("Something went wrong");
        // participants = participantData.participants!;
      }
      if (participantData.status!) {
        print(participantData.message!);
        Utility.showToast("Booking Cancelled Successfully");
        //  Navigator.pop(context);
      } else {
        Utility.showToast("Something went wrong");
        print(participantData.message!);
      }
    }
    //return participants;
  }

  void _showDialog(Participants participant) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Expanded(
                  //   flex: 1,
                  //   child: CustomButton(
                  //       height: 20,
                  //       fontSize: 16.0,
                  //       title: "Cancel Booking",
                  //       color: kBaseColor,
                  //       txtColor: Colors.white,
                  //       minWidth: 80,
                  //       onPressed: () async {
                  //         _dismissDialog();
                  //       }),
                  // ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                        height: 20,
                        fontSize: 16.0,
                        title: "Cancel Booking",
                        color: Colors.red,
                        txtColor: Colors.white,
                        minWidth: 80,
                        onPressed: () async {
                          _dismissDialog();
                          participant.status = "0";
                          await updateParticipant(participant);
                        }),
                  ),
                ],
              );
            },
          ),
          // actions: <Widget>[
          //   TextButton(
          //       onPressed: () {
          //         _dismissDialog();
          //       },
          //       child: Text('Close')),
          // ],
        );
      },
    );
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  Widget eventItem(Participants participant) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TournamentParticipants(
        //             event: participant.event, type: "1")));
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
//      padding: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
        // height: 200,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                // Utility.showToast("hi");
                _showDialog(participant);
              },
              child: Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.more_horiz,
                  size: 20,
                  color: kBaseColor,
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    height: 90.0,
                    width: 90.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        APIResources.IMAGE_URL +
                            participant.event!.image.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Row(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 100.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text(
                    participant.event!.name.toString(),
                    style: TextStyle(
                        color: kBaseColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    participant.event!.address.toString(),
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "participant name: ${participant.name}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Start Date: ${participant.event!.startDate.toString()}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Location: ${participant.event!.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    participant.paymentStatus == "2"
                        ? "Payment : Not Done"
                        : "Payment : Done",
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
                          "\u{20B9} ${participant.event!.entryFees}",
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
