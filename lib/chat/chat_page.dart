import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/allWidgets/loading_view.dart';
import 'package:player/chat/login_page.dart';
import 'package:player/chatmodels/message_chat.dart';
import 'package:player/chatprovider/auth_provider.dart';
import 'package:player/chatprovider/chat_provider.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/firestore_constants.dart';
import 'package:player/constant/utility.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;

  const ChatPage(
      {Key? key,
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
    chatProvider = context.read<ChatProvider>();
    // authProvider = context.read<AuthProvider>();

    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);

    readLocal();
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

  // Future getImage() async {
  //   ImagePicker imagePicker = ImagePicker();
  //   PickedFile? pickedFile;
  //
  //   pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     imageFile = File(pickedFile.path);
  //     if (imageFile != null) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //       uploadFile();
  //     }
  //   }
  // }

  // void getSticker() {
  //   focusNode.unfocus();
  //   setState(() {
  //     isShowSticker = !isShowSticker;
  //   });
  // }

  // Future uploadFile() async {
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   UploadTask uploadTask = chatProvider.uploadTask(imageFile!, fileName);
  //
  //   try {
  //     TaskSnapshot snapshot = await uploadTask;
  //     imageUrl = await snapshot.ref.getDownloadURL();
  //     setState(() {
  //       isLoading = false;
  //       onSendMessage(imageUrl, TypeMessage.image);
  //     });
  //   } on FirebaseException catch (e) {
  //     setState(() {
  //       isLoading = false;
  //       Utility.showToast(e.message ?? e.toString());
  //     });
  //   }
  // }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendMessage(
          content, type, groupChatId, currentUserId, peerId);

      listScrollController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
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

  void _callPhoneNumbe(String callPhoneNumber) async {
    var url = 'tel://$callPhoneNumber';
    // if(await launc(url)){
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${peerNickname}"),
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
                        buildItem(index, snapshot.data?.docs[index]),
                    itemCount: snapshot.data?.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                } else {
                  return Center(child: Text("Loading1"));
                }
              })
          : Center(child: Text("Loading2")),
    );
  }
}
