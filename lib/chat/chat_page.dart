import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/allWidgets/loading_view.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/chatmodels/message_chat.dart';
import 'package:player/chatprovider/auth_provider.dart';
import 'package:player/chatprovider/chat_provider.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/firestore_constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/friend_data.dart';
import 'package:player/service/local_notification_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  final String player1;
  final String player2;
  final String peerId;
  final String peerAvatar;
  final String peerNickname;

  const ChatPage(
      {Key? key,
      required this.conversationId,
      required this.player1,
      required this.player2,
      required this.peerId,
      required this.peerAvatar,
      required this.peerNickname})
      : super(key: key);

  @override
  State createState() => ChatPageState(
      peerId: this.peerId,
      peerAvatar: this.peerAvatar,
      peerNickname: this.peerNickname);
}

class ChatPageState extends State<ChatPage> {
  ChatPageState(
      {Key? key,
      required this.peerId,
      required this.peerAvatar,
      required this.peerNickname});

  String peerId;
  String peerAvatar;
  String peerNickname;
  late String currentUserId;
  late String currentPlayerName;

  List<QueryDocumentSnapshot> listMessage = new List.from([]);

  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";

  File? imageFile;
//  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  late ChatProvider chatProvider;
  //late AuthProvider authProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // FirebaseMessaging.onMessage.listen((message) {
    //   if (message.notification != null) {
    //     print("Do nothing");
    //   }
    // });

    chatProvider = context.read<ChatProvider>();
    // authProvider = context.read<AuthProvider>();

    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);

    readLocal();
    updateConversationStatus();
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  onFocusChange() {
    if (focusNode.hasFocus) {
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    // if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
    //   currentUserId = authProvider.getUserFirebaseId()!;
    // } else {
    //   Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => LoginPage()),
    //     (Route<dynamic> route) => false,
    //   );
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getString("fuid")!;
    currentPlayerName = prefs.getString("playerName")!;
    print("Current User ID Found ${currentUserId}");
    if (currentUserId.hashCode <= peerId.hashCode) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }
    setState(() {});
    chatProvider.updateDataFirestore(
      FirestoreContants.pathUserCollection,
      currentUserId,
      {FirestoreContants.chattingWith: peerId},
    );
  }

  void onSendMessage(String content, int type) async {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendMessage(
          content, type, groupChatId, currentUserId, peerId);

      listScrollController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);

      // Add Conversation

      await addConversation(widget.player1, widget.player2, content);
    } else {
      Utility.showToast("Nothing to send");
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get(FirestoreContants.idFrom) ==
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get(FirestoreContants.idFrom) !=
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      chatProvider.updateDataFirestore(FirestoreContants.pathUserCollection,
          currentUserId, {FirestoreContants.chattingWith: null});
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  void _callPhoneNumber(String callPhoneNumber) async {
    var url = 'tel://$callPhoneNumber';
    // if(await launc(url)){
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Utility.showToast("Peer avatar ${peerAvatar}");
                Navigator.pop(context);
              },
              child: Container(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: kBaseColor,
                ),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              child: CachedNetworkImage(
                imageUrl: peerAvatar == ""
                    ? APIResources.AVATAR_IMAGE
                    : APIResources.IMAGE_URL + peerAvatar,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: imageProvider,
                ),
                errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Image.network(
                    APIResources.AVATAR_IMAGE,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  peerNickname,
                  style: TextStyle(fontSize: 16, color: kBaseColor),
                ))
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: onBackPress,
        child: Stack(
          children: [
            Column(
              children: [buildListMessage(), buildInput()],
            ),
            //buildLoading()
          ],
        ),
      ),
    );
  }

  Widget buildSticker() {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () => onSendMessage("mim11", TypeMessage.sticker),
                  child: Image.asset("assets/images/coach.png"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget buildLoading() {
  //   return Positioned(child: isLoading ? LoadingView() : SizedBox.shrink());
  // }

  Widget buildInput() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: kServiceBoxItem,
      child: Row(
        children: [
          // image picker
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: Container(
                width: 10,
              ),
              // child: IconButton(
              //   icon: Icon(Icons.camera_enhance),
              //   onPressed: getImage,
              //   color: kBaseColor,
              // ),
            ),
            color: Colors.white,
          ),
          //text field for message
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, TypeMessage.text);
                },
                style: TextStyle(color: kBaseColor, fontSize: 15),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: "Type your message...",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                focusNode: focusNode,
              ),
            ),
          ),
          //send button
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () =>
                    onSendMessage(textEditingController.text, TypeMessage.text),
                color: kBaseColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      MessageChat messageChat = MessageChat.fromDocument(document);
      if (messageChat.idFrom == currentUserId) {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          alignment: Alignment.centerRight,
          child: Text(
            "${messageChat.content}",
            style: TextStyle(color: kBaseColor),
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            "${messageChat.content}",
            style: TextStyle(color: kBaseColor),
          ),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

  Widget buildChatItem(int index, DocumentSnapshot? document) {
    //if (document != null) {
    MessageChat messageChat = MessageChat.fromDocument(document!);
    //}
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Align(
        alignment: (messageChat.idFrom != currentUserId
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: (messageChat.idFrom != currentUserId
                ? kBaseColor
                : Colors.grey.shade200),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            messageChat.content,
            style: TextStyle(
                fontSize: 14,
                color: messageChat.idFrom != currentUserId
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }

  chatNotification(String playerId, String title, String content) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      await apiCall.chatNotification(playerId, title, content);
    }
  }

  addConversation(String player1, String player2, String message) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      await apiCall.addConversation(player1, player2, message);
    }

    await chatNotification(widget.player2,
        "New Message Received From $currentPlayerName", message);
  }

  // Widget buildItem(int index, DocumentSnapshot? document) {
  //   if (document != null) {
  //     MessageChat messageChat = MessageChat.fromDocument(document);
  //
  //     if (messageChat.idFrom == currentUserId) {
  //       return Row(children: [
  //         messageChat.type == TypeMessage.text
  //             ? Container(
  //                 child: Text(
  //                   messageChat.content,
  //                   style: TextStyle(color: kBaseColor),
  //                 ),
  //                 padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
  //                 width: 200,
  //                 decoration: kServiceBoxItem,
  //                 margin: EdgeInsets.only(
  //                   bottom: isLastMessageRight(index) ? 20 : 10,
  //                   right: 10,
  //                 ),
  //               )
  //             : messageChat.type == TypeMessage.image
  //                 ? Container(
  //                     child: OutlinedButton(
  //                       child: Material(
  //                         child: Image.network(
  //                           messageChat.content,
  //                           loadingBuilder: (BuildContext context, Widget child,
  //                               ImageChunkEvent? loadingProgress) {
  //                             if (loadingProgress == null) {
  //                               return child;
  //                             } else {
  //                               return Container(
  //                                 decoration: BoxDecoration(
  //                                   color: Colors.grey,
  //                                   borderRadius:
  //                                       BorderRadius.all(Radius.circular(8)),
  //                                 ),
  //                                 width: 200,
  //                                 height: 200,
  //                                 child: Center(
  //                                   child: CircularProgressIndicator(
  //                                       color: Colors.grey,
  //                                       value: loadingProgress
  //                                                   .expectedTotalBytes !=
  //                                               null
  //                                           ? loadingProgress
  //                                                   .cumulativeBytesLoaded /
  //                                               loadingProgress
  //                                                   .expectedTotalBytes!
  //                                           : null),
  //                                 ),
  //                               );
  //                             }
  //                           },
  //                           errorBuilder: (context, object, stackTrace) {
  //                             return Icon(
  //                               Icons.account_circle,
  //                               size: 50,
  //                               color: Colors.grey,
  //                             );
  //                           },
  //                         ),
  //                         borderRadius: BorderRadius.all(Radius.circular(8)),
  //                         clipBehavior: Clip.hardEdge,
  //                       ),
  //                       onPressed: () {},
  //                     ),
  //                     margin: EdgeInsets.only(
  //                         bottom: isLastMessageRight(index) ? 20 : 10,
  //                         right: 10),
  //                   )
  //                 : Container()
  //       ], mainAxisAlignment: MainAxisAlignment.end);
  //     } else {
  //       return Container(
  //         child: Column(
  //           children: [
  //             Row(
  //               children: [
  //                 isLastMessageLeft(index)
  //                     ? Material(
  //                         child: Image.network(peerAvatar,
  //                             errorBuilder: (context, object, stackTrace) {
  //                               return Icon(
  //                                 Icons.account_circle,
  //                                 size: 35,
  //                                 color: Colors.grey,
  //                               );
  //                             },
  //                             width: 35,
  //                             height: 35,
  //                             fit: BoxFit.cover,
  //                             loadingBuilder: (BuildContext context,
  //                                 Widget child,
  //                                 ImageChunkEvent? loadingProgress) {
  //                               if (loadingProgress == null) {
  //                                 return child;
  //                               } else {
  //                                 return Center(
  //                                   child: CircularProgressIndicator(
  //                                       color: Colors.grey,
  //                                       value: loadingProgress
  //                                                   .expectedTotalBytes !=
  //                                               null
  //                                           ? loadingProgress
  //                                                   .cumulativeBytesLoaded /
  //                                               loadingProgress
  //                                                   .expectedTotalBytes!
  //                                           : null),
  //                                 );
  //                               }
  //                             }),
  //                         borderRadius: BorderRadius.all(Radius.circular(18)),
  //                         clipBehavior: Clip.hardEdge,
  //                       )
  //                     : Container(
  //                         width: 35,
  //                       ),
  //                 messageChat.type == TypeMessage.text
  //                     ? Container(
  //                         width: 200,
  //                         child: Text(
  //                           messageChat.content,
  //                           style: TextStyle(color: kBaseColor),
  //                         ),
  //                         padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
  //                         decoration: kServiceBoxItem,
  //                         margin: EdgeInsets.only(left: 10),
  //                       )
  //                     : messageChat.type == TypeMessage.image
  //                         ? Container(
  //                             child: TextButton(
  //                               child: Material(
  //                                 child: Image.network(
  //                                   messageChat.content,
  //                                   loadingBuilder: (BuildContext context,
  //                                       Widget child,
  //                                       ImageChunkEvent? loadingProgress) {
  //                                     if (loadingProgress == null) {
  //                                       return child;
  //                                     } else {
  //                                       return Container(
  //                                         decoration: BoxDecoration(
  //                                           color: Colors.grey,
  //                                           borderRadius: BorderRadius.all(
  //                                               Radius.circular(8)),
  //                                         ),
  //                                         width: 200,
  //                                         height: 200,
  //                                         child: Center(
  //                                           child: CircularProgressIndicator(
  //                                               color: Colors.grey,
  //                                               value: loadingProgress
  //                                                           .expectedTotalBytes !=
  //                                                       null
  //                                                   ? loadingProgress
  //                                                           .cumulativeBytesLoaded /
  //                                                       loadingProgress
  //                                                           .expectedTotalBytes!
  //                                                   : null),
  //                                         ),
  //                                       );
  //                                     }
  //                                   },
  //                                   errorBuilder:
  //                                       (context, object, stackTrace) {
  //                                     return Icon(
  //                                       Icons.account_circle,
  //                                       size: 50,
  //                                       color: Colors.grey,
  //                                     );
  //                                   },
  //                                 ),
  //                                 borderRadius:
  //                                     BorderRadius.all(Radius.circular(8)),
  //                                 clipBehavior: Clip.hardEdge,
  //                               ),
  //                               onPressed: () {},
  //                             ),
  //                             margin: EdgeInsets.only(
  //                                 bottom: isLastMessageRight(index) ? 20 : 10,
  //                                 right: 10),
  //                           )
  //                         : Container()
  //               ],
  //             )
  //           ],
  //         ),
  //       );
  //     }
  //   } else {
  //     return SizedBox.shrink();
  //   }
  // }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: chatProvider.getChatStream(groupChatId, _limit),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessage.addAll(snapshot.data!.docs);
                  return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) =>
                        buildChatItem(index, snapshot.data?.docs[index]),
                    itemCount: snapshot.data?.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(color: kBaseColor));
                }
              })
          : Center(child: CircularProgressIndicator(color: kBaseColor)),
    );
  }

  Future<void> updateConversationStatus() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      FriendData friendData = await apiCall.updateConversationStatus(
          widget.conversationId, widget.player2);
      if (friendData.status!) {
        print(friendData.message!);
      } else {
        print(friendData.message!);
      }
    }
  }
}
