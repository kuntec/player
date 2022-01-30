import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/chat/chat_page.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/friend_data.dart';
import 'package:player/model/player_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  bool? isRequestSelected = false;
  var myPlayerId;
  var selectedPlayerId;
  int counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Init get friend");

    getRequestFriend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends"),
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
                          child: counter == 0
                              ? Text(
                                  'Request Friends',
                                  style: TextStyle(
                                      color: isRequestSelected!
                                          ? Colors.white
                                          : kBaseColor,
                                      fontSize: 14.0),
                                )
                              : Badge(
                                  shape: BadgeShape.square,
                                  borderRadius: BorderRadius.circular(10),
                                  position:
                                      BadgePosition.topEnd(top: 0, end: -20),
                                  padding: EdgeInsets.all(2),
                                  badgeContent: Text(
                                    '$counter',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  child: Text(
                                    'Request Friends',
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
                  ),
                ],
              ),
            ),
            isRequestSelected! ? requestFriends() : findFriends()
          ],
        ),
      ),
    );
  }

  String searchString = "";
  TextEditingController searchController = new TextEditingController();
  findFriends() {
    return Column(
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
        Container(
          child: allPlayers(),
        ),
      ],
    );
  }

//  List<Player>? players;

  Future<List<Player>> getPlayers() async {
    APICall apiCall = new APICall();
    List<Player> list = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? playerId = prefs.getInt("playerId");
      myPlayerId = playerId.toString();
      PlayerData playerData = await apiCall.getChatPlayer(playerId.toString());
      if (playerData.players != null) {
        list = playerData.players!;
        list = list.reversed.toList();
      }
    }
    return list;
  }

  allPlayers() {
    return Container(
      height: 700,
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
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Players'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 200),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return snapshot.data[index].name
                          .toString()
                          .toLowerCase()
                          .contains(searchString)
                      ? playerItem(snapshot.data[index])
                      : Container();
//                return playerItem();
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

  Widget playerItem(dynamic player) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration:
          kServiceBoxItem.copyWith(borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  height: 40.0,
                  width: 40.0,
                  child: player.image == null
                      ? CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/no_user.jpg'),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(
                            APIResources.IMAGE_URL + player.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                player.friend == null
                    ? GestureDetector(
                        onTap: () async {
                          // Utility.showToast(
                          //     "Send ${myPlayerId.toString()} to ${player.id}");
                          setState(() {
                            selectedPlayerId = player.id.toString();
                          });
                          addFriend(
                              myPlayerId.toString(), player.id.toString());
                        },
                        child: isLoading == true &&
                                selectedPlayerId == player.id.toString()
                            ? CircularProgressIndicator(color: kBaseColor)
                            : Container(
                                color: kBaseColor,
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Send Request",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                      )
                    : player.friend.status == "0"
                        ? Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBaseColor,
                                    width: 0,
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Requested",
                                  style: TextStyle(
                                    color: kBaseColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  removeFriend(
                                      myPlayerId, player.id.toString());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 0,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBaseColor,
                                    width: 0,
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Friend",
                                  style: TextStyle(
                                    color: kBaseColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  removeFriend(
                                      myPlayerId, player.id.toString());
                                  Utility.showToast("Unfriend");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 0,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "UnFriend",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12.0,
                                    ),
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
    );
  }

  bool? isLoading = false;

  requestFriends() {
    return Container(
      child: allRequestPlayers(),
    );
  }

  allRequestPlayers() {
    return Container(
      height: 700,
      child: FutureBuilder(
        future: getRequestFriend(),
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
                  child: Text('No Request Found'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 200),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return requestPlayerItem(snapshot.data[index]);
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

  Widget requestPlayerItem(dynamic friend) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: kServiceBoxItem,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  height: 40.0,
                  width: 40.0,
                  child: friend.player.image == null
                      ? CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/no_user.jpg'),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(
                            APIResources.IMAGE_URL + friend.player.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.player.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () async {
                updateFriend(myPlayerId, friend.player.id.toString(), "1");
                Utility.showToast("Confirm");
              },
              child: Container(
                margin: EdgeInsets.all(2),
                color: kBaseColor,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () async {
                removeFriend(myPlayerId, friend.player.id.toString());
                Utility.showToast("Cancel");
              },
              child: Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kBaseColor,
                    width: 0,
                  ),
                ),
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: kBaseColor,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addFriend(String playerId1, String playerId2) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      PlayerData playerData = await apiCall.addFriend(playerId1, playerId2);
      setState(() {
        isLoading = false;
      });
      if (playerData.status!) {
        print(playerData.message!);

        Utility.showToast(playerData.message!);
        setState(() {
          isLoading = false;
        });
        // Navigator.pop(context, true);
      } else {
        print(playerData.message!);
        Utility.showToast(playerData.message!);
      }
    }
  }

  updateFriend(String playerId1, String playerId2, String status) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      PlayerData playerData =
          await apiCall.updateFriend(playerId1, playerId2, status);
      setState(() {
        isLoading = false;
      });
      if (playerData.status!) {
        print(playerData.message!);

        Utility.showToast(playerData.message!);
        setState(() {
          isLoading = false;
        });
        // Navigator.pop(context, true);
      } else {
        print(playerData.message!);
        Utility.showToast(playerData.message!);
      }
    }
  }

  removeFriend(String playerId1, String playerId2) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      PlayerData playerData = await apiCall.removeFriend(playerId1, playerId2);
      setState(() {
        isLoading = false;
      });
      if (playerData.status!) {
        print(playerData.message!);

        Utility.showToast(playerData.message!);
        setState(() {
          isLoading = false;
        });
        // Navigator.pop(context, true);
      } else {
        print(playerData.message!);
        Utility.showToast(playerData.message!);
      }
    }
  }

  Future<List<Friends>> getRequestFriend() async {
    List<Friends> list = [];
    APICall apiCall = new APICall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? playerId = prefs.getInt("playerId");
    myPlayerId = playerId.toString();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      FriendData friendData = await apiCall.getRequestFriend(myPlayerId);
      if (friendData.friend != null) {
        list = friendData.friend!;
      }
      if (friendData.status!) {
        print(friendData.message!);
      } else {
        print(friendData.message!);
      }
      setState(() {
        counter = list.length;
      });
    }
    return list;
  }
}
