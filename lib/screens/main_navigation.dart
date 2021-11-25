import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/home.dart';
import 'package:player/screens/player_profile.dart';
import 'package:player/screens/service_screen.dart';
import 'package:player/screens/tournament_screen.dart';
import 'package:player/screens/venue_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;
  final screens = [
    HomeScreen(),
    TournamentScreen(),
    VenueScreen(),
    ServiceScreen(),
    PlayerProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
//        backgroundColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: kBaseColor,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              height: 20,
              width: 20,
              child: SvgPicture.asset("assets/images/home.svg",
                  color: selectedIndex == 0 ? kBaseColor : Colors.black87),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 20,
              width: 20,
              child: SvgPicture.asset("assets/images/tournament.svg",
                  color: selectedIndex == 1 ? kBaseColor : Colors.black87),
            ),
            label: "Tournament",
          ),
          BottomNavigationBarItem(
              icon: Container(
                height: 20,
                width: 20,
                child: SvgPicture.asset("assets/images/ground.svg",
                    color: selectedIndex == 2 ? kBaseColor : Colors.black87),
              ),
              label: "Venue"),
          BottomNavigationBarItem(
              icon: Container(
                height: 20,
                width: 20,
                child: SvgPicture.asset("assets/images/service.svg",
                    color: selectedIndex == 3 ? kBaseColor : Colors.black87),
              ),
              label: "Service"),
          BottomNavigationBarItem(
              icon: Container(
                height: 20,
                width: 20,
                child: SvgPicture.asset("assets/images/profile.svg",
                    color: selectedIndex == 4 ? kBaseColor : Colors.black87),
              ),
              label: "Profile"),
        ],
      ),
      // appBar: AppBar(
      //   leading: Icon(
      //     Icons.location_pin,
      //     color: Colors.white,
      //   ),
      //   actions: [
      //     Icon(
      //       Icons.notifications,
      //       color: Colors.white,
      //     ),
      //     SizedBox(width: 10.0),
      //     Icon(
      //       Icons.message_outlined,
      //       color: Colors.white,
      //     ),
      //     SizedBox(width: 10.0),
      //   ],
      //   title: Text(
      //     "VADODARA",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
    );
  }
}
