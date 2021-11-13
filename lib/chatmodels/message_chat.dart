import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:player/constant/firestore_constants.dart';

class MessageChat {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  MessageChat({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreContants.idFrom: this.idFrom,
      FirestoreContants.idTo: this.idTo,
      FirestoreContants.timestamp: this.timestamp,
      FirestoreContants.content: this.content,
      FirestoreContants.type: this.type,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get(FirestoreContants.idFrom);
    String idTo = doc.get(FirestoreContants.idTo);
    String timestamp = doc.get(FirestoreContants.timestamp);
    String content = doc.get(FirestoreContants.content);
    int type = doc.get(FirestoreContants.type);

    return MessageChat(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }
}
