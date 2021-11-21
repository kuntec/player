import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/custom_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/my_participant_data.dart';
import 'package:player/model/participant_data.dart';
import 'package:player/model/tournament_data.dart';
import 'package:player/screens/tournament_participants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTournaments extends StatefulWidget {
  dynamic player;
  MyTournaments({this.player});

  @override
  _MyTournamentsState createState() => _MyTournamentsState();
}

class _MyTournamentsState extends State<MyTournaments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tournaments"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            myTournament(),
          ],
        ),
      ),
    );
  }

  Widget myTournament() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(5.0),
      child: FutureBuilder(
        future: getMyTournaments(),
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
                  child: Text('No Tournaments'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 110),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return tournamentItem(snapshot.data[index]);
                },
              );
            }
          } else {
            return Container(
              child: Center(
                child: Text('No Tournaments'),
              ),
            );
          }
        },
      ),
    );
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

  List<Participants>? participants;

  Future<List<Participants>?> getMyTournaments() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      MyParticipantData myParticipantData =
          await apiCall.getTournamentParticipant(playerId.toString());
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

  Widget tournamentItem(Participants participant) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             TournamentParticipants(event: tournament, type: "0")));
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
//      padding: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
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
                    height: 85.0,
                    width: 85.0,
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
                        APIResources.IMAGE_URL +
                            participant.tournament!.image.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 110.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text(
                    participant.tournament!.tournamentName.toString(),
                    style: TextStyle(
                        color: kBaseColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Start Date: ${participant.tournament!.startDate.toString()}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Location: ${participant.tournament!.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "Location: ${participant.tournament!.sportName}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "\u{20B9} ${participant.tournament!.entryFees}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  // Text(
                  //   "Time: ${tournament.startTime} to ${tournament.startTime}",
                  //   style: TextStyle(
                  //     color: Colors.grey.shade900,
                  //     fontSize: 14.0,
                  //   ),
                  // ),
                  // SizedBox(height: 5.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
