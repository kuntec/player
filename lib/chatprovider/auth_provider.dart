import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:player/chatmodels/user_chat.dart';
import 'package:player/constant/firestore_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;

  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.prefs,
    required this.firebaseFirestore,
  });

  String? getUserFirebaseId() {
    return prefs.getString(FirestoreContants.id);
  }

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn &&
        prefs.getString(FirestoreContants.id)?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleSignIn() async {
    _status = Status.authenticating;
    notifyListeners();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreContants.pathUserCollection)
            .where(FirestoreContants.id, isEqualTo: firebaseUser.uid)
            .get();

        final List<DocumentSnapshot> document = result.docs;
        if (document.length == 0) {
          firebaseFirestore
              .collection(FirestoreContants.pathUserCollection)
              .doc(firebaseUser.uid)
              .set({
            FirestoreContants.nickname: firebaseUser.displayName,
            FirestoreContants.photoUrl: firebaseUser.photoURL,
            FirestoreContants.id: firebaseUser.uid,
            "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreContants.chattingWith: null
          });

          User? currentUser = firebaseUser;
          await prefs.setString(FirestoreContants.id, currentUser.uid);
          await prefs.setString(
              FirestoreContants.nickname, currentUser.displayName ?? "");
          await prefs.setString(
              FirestoreContants.photoUrl, currentUser.photoURL ?? "");
          await prefs.setString(
              FirestoreContants.phoneNumber, currentUser.phoneNumber ?? "");
        } else {
          DocumentSnapshot documentSnapshot = document[0];
          UserChat userChat = UserChat.fromDocument(documentSnapshot);

          await prefs.setString(FirestoreContants.id, userChat.id);
          await prefs.setString(FirestoreContants.nickname, userChat.nickname);
          await prefs.setString(FirestoreContants.photoUrl, userChat.photoUrl);
          await prefs.setString(
              FirestoreContants.phoneNumber, userChat.phoneNumber);
        }

        _status = Status.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        return false;
      }
    } else {
      _status = Status.authenticateCanceled;
      notifyListeners();
      return false;
    }
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }
}
