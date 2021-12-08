import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/dialogbuilder.dart';
import 'package:player/constant/loading_indicator.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/my_sport.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/model/tournament_data.dart';
import 'package:player/screens/tournament_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({Key? key}) : super(key: key);

  @override
  _TournamentScreenState createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen>
    with AutomaticKeepAliveClientMixin<TournamentScreen> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  int selectedIndex = 1;
  List<Sports> sports = [];

  List<Data> allSports = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMySports();
    getSports();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("TOURNAMENTS"),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: sportBarList()),
              Expanded(flex: 8, child: allTournaments()),
            ],
          ),
        ),
      ),
    );
  }

  Widget allTournaments() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(10.0),
      child: FutureBuilder(
        future: getTournaments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Container(
                  child: CircularProgressIndicator(color: kBaseColor)),
            );
          }
          if (snapshot.hasData) {
            print("Has Data ${snapshot.data.length}");
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Data'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 20),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return tournamentItem2(snapshot.data[index]);
                },
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

  List<Tournament>? tournaments;

  Future<List<Tournament>?> getTournaments() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");
      var locationId = prefs.get("locationId");
      TournamentData tournamentData =
          await apiCall.getTournament(locationId.toString(), selectedSportId);
      if (tournamentData.tournaments != null) {
        tournaments = tournamentData.tournaments!;
        tournaments = tournaments!.reversed.toList();
      }

      if (tournamentData.status!) {
      } else {
        print(tournamentData.message!);
      }
    } else {
      Utility.showToast("NO INTERNET CONNECTION");
    }

    return tournaments;
  }

  Widget tournamentItem2(dynamic tournament) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TournamentDetails(
                      tournament: tournament,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
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
                        APIResources.IMAGE_URL + tournament.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 130.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          height: 20,
                          child: Text(
                            tournament.tournamentName,
                            style: TextStyle(
                              color: kBaseColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              color: kBaseColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              )),
                          width: 90,
                          height: 30,
                          child: Center(
                            child: Text(
                              tournament.sportName,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                    "Start Time: ${tournament.startTime}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "End Time: ${tournament.endTime}",
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
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: kServiceBoxItem.copyWith(
                            color: kBaseColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            )),
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
                        child: Text(
                          "\u{20B9}  ${tournament.entryFees}",
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

  Widget sportBarList() {
    return sports != null
        ? Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                )
              ],
            ),
            height: 50,
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sports.length,
                itemBuilder: (BuildContext context, int index) {
                  return sportChip(sports[index]);
                },
              ),
            ),
          )
        : Container();
  }

  Widget sportChip(sport) {
    return GestureDetector(
      onTap: () {
        if (sport.sportId == null) {
          sports.removeLast();
          for (int i = 0; i < allSports.length; i++) {
            bool status = false;
            for (int j = 0; j < sports.length; j++) {
              if (allSports[i].sportName == sports[j].sportName) {
                status = false;

                break;
              } else {
                status = true;
              }
            }
            if (status) {
              print("Sport Name ${allSports[i].sportName}");
              Sports s = new Sports();
              s.sportName = allSports[i].sportName;
              s.sportId = allSports[i].id.toString();
              sports.add(s);
            }
          }
        } else {
          selectedSportId = sport.sportId.toString();
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            width: 1.0,
            color: sport.sportId.toString() == selectedSportId
                ? kBaseColor
                : Colors.white,
          ),
          color: sport.sportId.toString() == selectedSportId
              ? kBaseColor
              : Colors.white,
        ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            sport.sportName,
            style: TextStyle(
                color: sport.sportId.toString() == selectedSportId
                    ? Colors.white
                    : Colors.black,
                fontSize: 12.0),
          ),
        ),
      ),
    );
  }

  var selectedSportId = "0";

  Future<List<Sports>> getMySports() async {
    APICall apiCall = new APICall();
    // List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");
      MySport mySport = await apiCall.getMySports(playerId.toString());

      if (mySport.sports != null) {
        Sports s = new Sports();
        s.sportName = "All";
        s.sportId = "0";
        sports.clear();
        sports.add(s);
        sports.addAll(mySport.sports!);
        Sports s2 = new Sports();
        s2.sportName = "Others";
        s2.sportId = null;
        sports.add(s2);
        setState(() {});
      }
    } else {}
    return sports;
  }

  Future<List<Data>> getSports() async {
    APICall apiCall = new APICall();
    List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SportData sportData = await apiCall.getSports();

      if (sportData.data != null) {
        data.addAll(sportData.data!);
        allSports = data;
      }
    } else {}
    return data;
  }
}
