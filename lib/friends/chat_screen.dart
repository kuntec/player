import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/chat/chat_page.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/friend_data.dart';
import 'package:player/model/player_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool? isRequestSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
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
                            "New Connection",
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
                            "Friends",
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
            isRequestSelected! ? requestFriends() : findFriends()
//             isRequestSelected!
//                 ? requestFriends()
//                 : Container(
//                     child: Center(
//                       child: Text("Coming Soon"),
//                     ),
//                   )
          ],
        ),
      ),
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

      PlayerData playerData = await apiCall.getChatPlayer(playerId.toString());
      if (playerData.players != null) {
        list = playerData.players!;
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
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Connection Found'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 200),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return playerItem(snapshot.data[index]);
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
    return GestureDetector(
      onTap: () {
        // Utility.showToast(player.name.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                    playerId: player.id.toString(),
                    peerId: player.fuid.toString(),
                    peerAvatar: player.image.toString(),
                    peerNickname: player.name.toString())));
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

  bool? isLoading = false;

  requestFriends() {
    return Container(
      child: listPlayerFriends(),
    );
  }

  listPlayerFriends() {
    return Container(
      height: 700,
      child: FutureBuilder(
        future: listFriend(),
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
                  child: Text('No Friends Found'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 200),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return friendItem(snapshot.data[index]);
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

  Widget friendItem(dynamic friend) {
    return friend.status == "1"
        ? GestureDetector(
            onTap: () {
              //Utility.showToast("fuid ${friend.player.fUid.toString()}");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(
                          playerId: friend.player.id.toString(),
                          peerId: friend.player.fUid.toString(),
                          peerAvatar: friend.player.image.toString(),
                          peerNickname: friend.player.name.toString())));
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: kServiceBoxItem.copyWith(
                  borderRadius: BorderRadius.circular(5)),
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
                              ? FlutterLogo()
                              : ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Image.network(
                                    APIResources.IMAGE_URL +
                                        friend.player.image,
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
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }

  Future<List<Friends>> listFriend() async {
    List<Friends> list = [];
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? playerId = prefs.getInt("playerId");
      FriendData friendData = await apiCall.listFriend(playerId.toString());
      if (friendData.friend != null) {
        list = friendData.friend!;
      }
      if (friendData.status!) {
        print(friendData.message!);
      } else {
        print(friendData.message!);
      }
    }
    return list;
  }
}
