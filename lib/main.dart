import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/add_details.dart';
import 'package:player/screens/add_host_activity.dart';
import 'package:player/screens/home.dart';
import 'package:player/screens/login.dart';
import 'package:player/screens/my_games.dart';
import 'package:player/screens/service_screen.dart';
import 'package:player/screens/splash.dart';
import 'package:player/screens/tournament_screen.dart';
import 'package:player/screens/venue_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kAppColor,
//        primarySwatch: kAppColor,
      ),
//      home: AddDetails(phoneNumber: "9409394242"),
//      home: HomeScreen(),
//      home: AddHost(),
//      home: TournamentScreen(),
//      home: VenueScreen(),
      home: ServiceScreen(),
      // routes: {
      //   "login": (_) => LoginScreen(),
      //   "home": (_) => HomeScreen(),
      // },
    );
  }
}
