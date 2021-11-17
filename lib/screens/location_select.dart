import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:player/constant/utility.dart';

class LocationSelectScreen extends StatefulWidget {
  const LocationSelectScreen({Key? key}) : super(key: key);

  @override
  _LocationSelectScreenState createState() => _LocationSelectScreenState();
}

class _LocationSelectScreenState extends State<LocationSelectScreen> {
  String currentAddress = "";
  //Position? currentPosition;

  // Future<void> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     Utility.showToast('Please keep your location on');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       Utility.showToast('Location Permission is denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     Utility.showToast('Location Permission is denied forever');
  //   }
  //
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       currentPosition = position;
  //       currentAddress = "${place.locality}";
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // currentAddress != null
            //     ? Text("${currentAddress}")
            //     : Text("currentAddress"),
            // currentPosition != null
            //     ? Text("${currentPosition!.latitude}")
            //     : Text("latitude"),
            // currentPosition != null
            //     ? Text("${currentPosition!.longitude}")
            //     : Text("longitude"),
            // TextButton(
            //     onPressed: () {
            //       _determinePosition();
            //     },
            //     child: Text("Locate Me")),
          ],
        ),
      ),
    ));
  }
}
