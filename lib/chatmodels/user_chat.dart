import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:player/constant/firestore_constants.dart';

class UserChat {
  String id;
  String photoUrl;
  String nickname;
  String aboutMe;
  String phoneNumber;

  UserChat({
    required this.id,
    required this.photoUrl,
    required this.nickname,
    required this.aboutMe,
    required this.phoneNumber,
  });

  Map<String, String> toJson() {
    return {
      FirestoreContants.nickname: nickname,
      FirestoreContants.aboutMe: aboutMe,
      FirestoreContants.photoUrl: photoUrl,
      FirestoreContants.phoneNumber: phoneNumber,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String photoUrl = "";
    String nickname = "";
    String aboutMe = "";
    String phoneNumber = "";

    try {
      aboutMe = doc.get(FirestoreContants.aboutMe);
    } catch (e) {}

    try {
      nickname = doc.get(FirestoreContants.nickname);
    } catch (e) {}

    try {
      photoUrl = doc.get(FirestoreContants.photoUrl);
    } catch (e) {}

    try {
      phoneNumber = doc.get(FirestoreContants.phoneNumber);
    } catch (e) {}

    return UserChat(
      id: doc.id,
      photoUrl: photoUrl,
      nickname: nickname,
      aboutMe: aboutMe,
      phoneNumber: phoneNumber,
    );
  }
}
