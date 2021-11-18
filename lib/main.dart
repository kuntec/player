import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:player/chat/login_page.dart';
import 'package:player/chatprovider/auth_provider.dart';
import 'package:player/chatprovider/chat_provider.dart';
import 'package:player/chatprovider/home_provider.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/add_host_activity.dart';
import 'package:player/screens/home.dart';
import 'package:player/screens/location_select.dart';
import 'package:player/screens/login.dart';
import 'package:player/screens/main_navigation.dart';
import 'package:player/service/local_notification_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("Background Handler ${message.data.toString()}");
  print("Background Handler ${message.notification!.title}");
  print("Background Handler ${message.notification!.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            firebaseAuth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
            prefs: prefs,
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        Provider<HomeProvider>(
          create: (_) =>
              HomeProvider(firebaseFirestore: this.firebaseFirestore),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            firebaseStorage: this.firebaseStorage,
            firebaseFirestore: this.firebaseFirestore,
            prefs: this.prefs,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Player',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
//        primarySwatch: kAppColor,
        ),
        // home: LoginPage(),
//      home: AddDetails(phoneNumber: "9409394242"),
//      home: HomeScreen(),
//      home: AddHost(),
//      home: TournamentScreen(),
//      home: VenueScreen(),
//      home: ServiceScreen(),
        home: LoginScreen(
          prefs: this.prefs,
        ),
//      home: LocationSelectScreen(),
//      home: MainNavigation(),
        // routes: {
        //   "login": (_) => LoginScreen(),
        //   "home": (_) => HomeScreen(),
        // },
      ),
    );
  }
}
