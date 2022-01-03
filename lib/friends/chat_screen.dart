import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/chat/chat_page.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/time_ago.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/conversation_data.dart';
import 'package:player/model/friend_data.dart';
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: topBar()),
            Expanded(flex: 9, child: bottomBar()),
          ],
        ),
      ),
    );
  }

  Widget bottomBar() {
    return isRequestSelected! ? requestFriends() : findFriends();
  }

  Widget top() {
    return Container(
      color: kBaseColor,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Text(
                "New Connection",
                style: TextStyle(color: kBaseColor, fontSize: 14.0),
              ),
            ),
          ),
          Container(),
        ],
      ),
    );
  }

  Widget bottom() {
    return Container(
      color: Colors.red,
      child: Text("Hello"),
    );
  }

  Widget topBar() {
    return Container(
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
                height: 40,
                padding: EdgeInsets.all(10),
                decoration: kContainerTabLeftDecoration.copyWith(
                    color: isRequestSelected! ? Colors.white : kBaseColor),
                child: Center(
                  child: Text(
                    "New Connection",
                    style: TextStyle(
                        color: isRequestSelected! ? kBaseColor : Colors.white,
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
                height: 40,
                padding: EdgeInsets.all(10),
                decoration: kContainerTabRightDecoration.copyWith(
                    color: isRequestSelected! ? kBaseColor : Colors.white),
                child: Center(
                  child: Text(
                    "Friends",
                    style: TextStyle(
                        color: isRequestSelected! ? Colors.white : kBaseColor,
                        fontSize: 14.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Conversation>? conversations;

  Future<List<Conversation>?> getPlayers() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      playerId = prefs.getInt("playerId");
      print("Player id $playerId");
      ConversationData conversationData =
          await apiCall.getMyConversation(playerId.toString());
      if (conversationData.conversation != null) {
        conversations = conversationData.conversation!;
        conversations = conversations!.reversed.toList();

        for (Conversation c in conversations!) {
          int count = 0;
          for (Reply r in c.reply!) {
            if (r.status == "0" &&
                r.playerId.toString() != playerId.toString()) {
              count = count + 1;
            }
            c.unread = count.toString();
            print("Conversation ${c.id} count $count");
          }
        }
      }
    }
    return conversations;
  }

  allPlayers() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(10.0),
      child: FutureBuilder(
        future: getPlayers(),
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
                  child: Text('No Connection Found'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 100),
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

  Widget playerItem(dynamic conversation) {
    return GestureDetector(
      onTap: () async {
//        Utility.showToast(conversation.id.toString());
        if (playerId == conversation.player1.id) {
          var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                      conversationId: conversation.id.toString(),
                      player1: playerId.toString(),
                      player2: conversation.player2.id.toString(),
                      peerId: conversation.player2.fUid.toString(),
                      peerAvatar: conversation.player2.image.toString(),
                      peerNickname: conversation.player2.name.toString())));

          setState(() {});
        } else {
          var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                      conversationId: conversation.id.toString(),
                      player1: playerId.toString(),
                      player2: conversation.player1.id.toString(),
                      peerId: conversation.player1.fUid.toString(),
                      peerAvatar: conversation.player1.image.toString(),
                      peerNickname: conversation.player1.name.toString())));
          setState(() {});
        }
      },
      child: Container(
        decoration: kServiceBoxItem,
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 50,
                child: playerId == conversation.player1.id
                    ? CachedNetworkImage(
                        imageUrl: conversation.player2.image == null
                            ? APIResources.AVATAR_IMAGE
                            : APIResources.IMAGE_URL +
                                conversation.player2.image,
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: imageProvider,
                        ),
                        errorWidget: (context, url, error) => FlutterLogo(),
                      )
                    : CachedNetworkImage(
                        imageUrl: conversation.player1.image == null
                            ? APIResources.AVATAR_IMAGE
                            : APIResources.IMAGE_URL +
                                conversation.player1.image,
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: imageProvider,
                        ),
                        errorWidget: (context, url, error) => FlutterLogo(),
                      ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      playerId == conversation.player1.id
                          ? "${conversation.player2.name}"
                          : "${conversation.player1.name}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: Text(
                      "${conversation.reply.last.message}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  conversation.unread == "0"
                      ? SizedBox.shrink()
                      : Container(
                          margin: EdgeInsets.all(5),
                          alignment: Alignment.topRight,
                          child: Badge(
                            position: BadgePosition.topStart(top: 5, start: 5),
                            badgeContent: Text(
                              '${conversation.unread}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                  SizedBox(height: 5),
                  Container(
                    child: Text(
                      "${TimeAgo.timeAgoSinceDate(conversation.reply.last.createdAt.toString())}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            // conversation.unread == "1"
            //     ? SizedBox.shrink()
            //     : Expanded(
            //         flex: 1,
            //         child: Container(
            //           margin: EdgeInsets.all(5),
            //           alignment: Alignment.topRight,
            //           child: Badge(
            //             position: BadgePosition.topStart(top: 5, start: 5),
            //             badgeContent: Text(
            //               '${conversation.unread}',
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //         ),
            //       ),
          ],
        ),
      ),
      // child: Container(
      //   margin: EdgeInsets.only(bottom: 10.0),
      //   decoration: kServiceBoxItem,
      //   // height: 200,
      //   child: Stack(
      //     children: [
      //       Container(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             conversation.unread == "1"
      //                 ? SizedBox.shrink()
      //                 : Container(
      //                     margin: EdgeInsets.all(5),
      //                     alignment: Alignment.topRight,
      //                     child: Badge(
      //                       position: BadgePosition.topStart(top: 5, start: 5),
      //                       badgeContent: Text(
      //                         '${conversation.unread}',
      //                         style: TextStyle(color: Colors.white),
      //                       ),
      //                     ),
      //                   ),
      //             Container(
      //               margin: EdgeInsets.all(10.0),
      //               height: 50.0,
      //               width: 50.0,
      //               child: playerId == conversation.player1.id
      //                   ? conversation.player2.image == null
      //                       ? FlutterLogo()
      //                       : ClipRRect(
      //                           borderRadius:
      //                               BorderRadius.all(Radius.circular(5.0)),
      //                           child: Image.network(
      //                             APIResources.IMAGE_URL +
      //                                 conversation.player2.image,
      //                             fit: BoxFit.fill,
      //                           ),
      //                         )
      //                   : conversation.player1.image == null
      //                       ? FlutterLogo()
      //                       : ClipRRect(
      //                           borderRadius:
      //                               BorderRadius.all(Radius.circular(5.0)),
      //                           child: Image.network(
      //                             APIResources.IMAGE_URL +
      //                                 conversation.player1.image,
      //                             fit: BoxFit.fill,
      //                           ),
      //                         ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: EdgeInsets.only(left: 70.0, right: 5.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             SizedBox(height: 10.0),
      //             Text(
      //               playerId == conversation.player1.id
      //                   ? "${conversation.player2.name}"
      //                   : "${conversation.player1.name}",
      //               style: TextStyle(
      //                   color: Colors.black,
      //                   fontSize: 16.0,
      //                   fontWeight: FontWeight.bold),
      //             ),
      //             SizedBox(height: 5),
      //             Text(
      //               "${conversation.reply.last.message}",
      //               style: TextStyle(
      //                   color: Colors.grey,
      //                   fontSize: 12.0,
      //                   fontWeight: FontWeight.bold),
      //             ),
      //             SizedBox(height: 5.0),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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

  // Widget item2(dynamic friend) {
  //   return Container(child: Text("test"));
  // }

  Widget friendItem(dynamic friend) {
    return friend.status == "1"
        ? GestureDetector(
            onTap: () {
              //Utility.showToast("fuid ${friend.player.fUid.toString()}");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(
                          conversationId: "",
                          player1: playerId.toString(),
                          player2: friend.player.id.toString(),
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

  int? playerId;
  Future<List<Friends>> listFriend() async {
    List<Friends> list = [];
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      playerId = prefs.getInt("playerId");
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
