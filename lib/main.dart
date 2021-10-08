import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/home.dart';
import 'package:player/screens/location_select.dart';
import 'package:player/screens/login.dart';
import 'package:player/screens/main_navigation.dart';

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
        primaryColor: Colors.white,
//        primarySwatch: kAppColor,
      ),
//      home: AddDetails(phoneNumber: "9409394242"),
//      home: HomeScreen(),
//      home: AddHost(),
//      home: TournamentScreen(),
//      home: VenueScreen(),
//      home: ServiceScreen(),
//      home: LoginScreen(),
//      home: LocationSelectScreen(),
      home: MainNavigation(),
      // routes: {
      //   "login": (_) => LoginScreen(),
      //   "home": (_) => HomeScreen(),
      // },
    );
  }
}
