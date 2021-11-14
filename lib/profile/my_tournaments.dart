import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
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

  List<Tournament>? tournaments;

  Future<List<Tournament>?> getMyTournaments() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      TournamentData tournamentData =
          await apiCall.getMyTournament(playerId.toString());
      if (tournamentData.tournaments != null) {
        tournaments = tournamentData.tournaments!;
        tournaments = tournaments!.reversed.toList();
        //setState(() {});
      }

      if (tournamentData.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(tournamentData.message!);
      }
    }
    return tournaments;
  }

  Widget tournamentItem(dynamic tournament) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TournamentParticipants(event: tournament, type: "0")));
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
                        APIResources.IMAGE_URL + tournament.image,
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
                    tournament.tournamentName,
                    style: TextStyle(
                        color: kBaseColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Start Date: ${tournament.startDate}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Location: ${tournament.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "Location: ${tournament.sportName}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "\u{20B9} ${tournament.entryFees}",
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
