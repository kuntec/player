import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/participant_data.dart';

class TournamentParticipants extends StatefulWidget {
  dynamic event;
  dynamic type;
  TournamentParticipants({this.event, this.type});

  @override
  _TournamentParticipantsState createState() => _TournamentParticipantsState();
}

class _TournamentParticipantsState extends State<TournamentParticipants> {
  bool? isOfflineSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getParticipant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Participants")),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBaseColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Participants name and payment mode",
                style: TextStyle(color: Colors.black54),
              ),
            ),
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
                          isOfflineSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabLeftDecoration.copyWith(
                            color:
                                isOfflineSelected! ? Colors.white : kBaseColor),
                        child: Center(
                          child: Text(
                            "Online Mode",
                            style: TextStyle(
                                color: isOfflineSelected!
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
                          isOfflineSelected = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabRightDecoration.copyWith(
                            color:
                                isOfflineSelected! ? kBaseColor : Colors.white),
                        child: Center(
                          child: Text(
                            "Offline Mode",
                            style: TextStyle(
                                color: isOfflineSelected!
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
            isOfflineSelected! ? offline() : online()
          ],
        ),
      ),
    );
  }

  Widget online() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(5.0),
      child: FutureBuilder(
        future: getParticipant(1),
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
            if (snapshot.data.length != 0) {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 110),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return onlineItem(snapshot.data[index]);
                },
              );
            } else {
              return Container(
                child: Center(
                  child: Text('No Participants'),
                ),
              );
            }
          } else {
            print("No Data ");
            return Container(
              child: Center(
                child: Text('No Participants'),
              ),
            );
          }
        },
      ),
    );
  }

  Widget offline() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(5.0),
      child: FutureBuilder(
        future: getParticipant(0),
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
            if (snapshot.data.length != 0) {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 110),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return offlineItem(snapshot.data[index]);
                },
              );
            } else {
              return Container(
                child: Center(
                  child: Text('No Participants'),
                ),
              );
            }
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

  List<Participant>? participants;

  Future<List<Participant>?> getParticipant(int mode) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      ParticipantData participantData = await apiCall.getParticipant(
          widget.event.id.toString(), widget.type.toString());
      if (participantData.participants != null) {
        participants = participantData.participants!;
        //setState(() {});
      }
      if (participantData.status!) {
        print(participantData.message!);
        //  Navigator.pop(context);
      } else {
        participants = [];
        print(participantData.message!);
      }
    }
    return participants;
  }

  onlineItem(dynamic participant) {
    return participant.paymentMode == "1"
        ? Container(
            decoration: kBoxDecor,
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "${participant.name}",
                    style: TextStyle(color: Colors.black87, fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: Text(
                    "${participant.number}",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: Text(
                    "Gender: ${participant.gender}",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: Text(
                    "Age: ${participant.age}",
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }

  offlineItem(dynamic participant) {
    return participant.paymentMode == "0"
        ? GestureDetector(
            onTap: () {
              Utility.launchCall(participant.number);
            },
            child: Container(
              decoration: kBoxDecor,
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "${participant.name}",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 18.0),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          "${participant.number}",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 14.0),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          "Gender: ${participant.gender}",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 14.0),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          "Age: ${participant.age}",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                  // participant.paymentStatus == "2"
                  //     ?
                  Container(
                    child: Row(
                      children: [
                        Text(
                          participant.paymentStatus == "0" ? "Unpaid" : "Paid",
                          style: TextStyle(
                              color: participant.paymentStatus == "0"
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 16.0),
                        ),
                        SizedBox(width: 10),
                        // Container(
                        //   child: Icon(
                        //     Icons.check_box,
                        //     color: participant.paymentStatus == "0"
                        //         ? Colors.white
                        //         : Colors.green,
                        //     size: 30.0,
                        //   ),
                        // ),
                        // Container(
                        //   child: Icon(
                        //     Icons.check_box,
                        //     color: participant.paymentStatus == "1"
                        //         ? Colors.white
                        //         : Colors.red,
                        //     size: 30.0,
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () async {
                            participant.paymentStatus = "1";
                            await updateParticipant(participant);
                            setState(() {});
                          },
                          child: Container(
                            decoration: kServiceBoxItem.copyWith(
                              color: participant.paymentStatus == "0"
                                  ? Colors.white
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                            child: Icon(
                              Icons.check,
                              color: participant.paymentStatus == "0"
                                  ? Colors.green
                                  : Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            participant.paymentStatus = "0";
                            await updateParticipant(participant);
                            setState(() {});
                          },
                          child: Container(
                            decoration: kServiceBoxItem.copyWith(
                              color: participant.paymentStatus == "1"
                                  ? Colors.white
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                            child: Icon(
                              Icons.clear,
                              color: participant.paymentStatus == "1"
                                  ? Colors.red
                                  : Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // : Container(
                  //     margin: EdgeInsets.all(10.0),
                  //     child: Text(
                  //       participant.paymentStatus == "0"
                  //           ? "Unpaid"
                  //           : "Paid",
                  //       style: TextStyle(
                  //           color: participant.paymentStatus == "0"
                  //               ? Colors.red
                  //               : Colors.green,
                  //           fontSize: 16.0),
                  //     ),
                  //   ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }

  Future<List<Participant>?> updateParticipant(Participant participant) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      ParticipantData participantData =
          await apiCall.updateParticipant(participant);
      if (participantData.participants != null) {
        participants = participantData.participants!;
      }
      if (participantData.status!) {
        print(participantData.message!);
        //  Navigator.pop(context);
      } else {
        print(participantData.message!);
      }
    }
    return participants;
  }
}
