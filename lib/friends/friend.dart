import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/player_data.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  bool? isRequestSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: k20Margin),
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
                          isRequestSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabLeftDecoration.copyWith(
                            color:
                                isRequestSelected! ? Colors.white : kBaseColor),
                        child: Center(
                          child: Text(
                            "Find Friends",
                            style: TextStyle(
                                color: isRequestSelected!
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
                          isRequestSelected = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabRightDecoration.copyWith(
                            color:
                                isRequestSelected! ? kBaseColor : Colors.white),
                        child: Center(
                          child: Text(
                            "Request Friends",
                            style: TextStyle(
                                color: isRequestSelected!
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
            isRequestSelected! ? RequestFriends() : findFriends()
          ],
        ),
      ),
    );
  }

  List<Player>? players;

  Future<List<Player>> getPlayers() async {
    APICall apiCall = new APICall();
    List<Player> list = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      PlayerData playerData = await apiCall.getPlayers();
      if (playerData.players != null) {
        list = playerData.players!;
        setState(() {
          players = list;
        });
      }
    }
    return list;
  }

  allPlayers() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(20.0),
      child: FutureBuilder(
        future: getPlayers(),
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
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 200),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return playerItem(snapshot.data[index]);
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

  Widget playerItem(dynamic player) {
    return GestureDetector(
      onTap: () {
        Utility.showToast(player.name.toString());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: kContainerBoxDecoration,
        // height: 200,
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    height: 40.0,
                    width: 40.0,
                    child: player.image == null
                        ? FlutterLogo()
                        : ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Image.network(
                              APIResources.IMAGE_URL + player.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
//                  Row(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 70.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    player.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  findFriends() {
    return Container(
      child: allPlayers(),
    );
  }

  RequestFriends() {
    return Container(
      child: Text("Request Friends"),
    );
  }
}
