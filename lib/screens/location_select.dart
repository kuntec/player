import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/location_data.dart';
import 'package:player/model/player_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationSelectScreen extends StatefulWidget {
  @override
  _LocationSelectScreenState createState() => _LocationSelectScreenState();
}

class _LocationSelectScreenState extends State<LocationSelectScreen> {
  bool isLoading = false;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            locations != null
                ? buildLocationData(locations!)
                : Container(child: Text("Loading...")),
            SizedBox(height: k20Margin),
            isLoading
                ? CircularProgressIndicator()
                : RoundedButton(
                    title: "UPDATE",
                    color: kBaseColor,
                    txtColor: Colors.white,
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      player!.locationId = this.selectedLocation!.id.toString();
                      player!.city = this.selectedLocation!.name.toString();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString(
                          "locationId", player!.locationId.toString());
                      prefs.setString("city", player!.city.toString());
                      await updatePlayer();
                    },
                  ),
          ],
        ),
      ),
    ));
  }

  updatePlayer() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      if (player!.email == null) {
        player!.email = "";
      }
      PlayerData playerData = await apiCall.updatePlayer(player!);
      if (playerData.status!) {
        //showToast(playerData.message!);
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context, true);
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(playerData.message!);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showToast(kInternet);
    }
  }

  List<Location>? locations;
  getLocation() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      LocationData locationData = await apiCall.getLocation();
      if (locationData.location != null) {
        locations = locationData.location;
        for (Location l in locations!) {
          if (l.id.toString() == player!.locationId.toString()) {
            this.selectedLocation = l;
          }
        }
        setState(() {});
      }
    } else {
      showToast(kInternet);
    }
  }

  Location? selectedLocation;
  Widget buildLocationData(List<Location> location) {
    return DropdownButton<Location>(
      value: selectedLocation != null ? selectedLocation : null,
      hint: Text("Select Location"),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: kBaseColor,
      ),
      onChanged: (Location? newValue) {
        // this._selectedLK = newValue!;
        setState(() {
          this.selectedLocation = newValue!;
        });
      },
      items: location.map<DropdownMenuItem<Location>>((Location value) {
        return DropdownMenuItem<Location>(
          value: value,
          child: Text(value.name!),
        );
      }).toList(),
    );
  }

  Player? player;
  getMyProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var playerId = prefs.get("playerId");
    var playerName = prefs.get("playerName");
    var mobile = prefs.get("mobile");
    //Utility.showToast("Player ${playerId} mobile ${mobile}");
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      print("Player " + mobile.toString());
//      showToast("Player " + phoneNumber);
      PlayerData playerData = await apiCall.checkPlayer(mobile.toString());

      if (playerData.status!) {
        setState(() {
          player = playerData.player;
        });

        getLocation();
        //  Utility.showToast("Player Found ${playerData.player!.image}");
      }
    }
  }
}
