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
  String searchString = "";
  TextEditingController searchController = new TextEditingController();
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
      bottomSheet: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
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
                  prefs.setString("locationId", player!.locationId.toString());
                  prefs.setString("city", player!.city.toString());
                  await updatePlayer();
                },
              ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: kServiceBoxItem,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchString = value;
                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                      color: kBaseColor,
                    ),
                  ),
                ),
              ),
              // locations != null
              //     ? buildLocationData(locations!)
              //     : Container(child: Text("Loading...")),
              SizedBox(height: k20Margin),
              myLocations(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget myLocations() {
    return Container(
      height: 700,
      child: FutureBuilder(
        future: getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: kServiceBoxItem,
                child: Center(
                    child: CircularProgressIndicator(
                  color: kBaseColor,
                )),
              ),
            );
          }
          if (snapshot.hasData) {
            print("Has Data ${snapshot.data.length}");
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Location'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 110),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  // return eventItem(snapshot.data[index]);
                  return snapshot.data[index].name
                          .toString()
                          .toLowerCase()
                          .contains(searchString)
                      ? locationItem(snapshot.data[index])
                      : SizedBox.shrink();
                },
              );
            }
          } else {
            return Container(
              child: Center(
                child: Text('No Data'),
              ),
            );
          }
        },
      ),
    );
  }

  locationItem(dynamic location) {
    return GestureDetector(
      onTap: () {
        this.currentLocation = location;
        this.selectedLocation = location;
        setState(() {});
      },
      child: Container(
        decoration: kServiceBoxItem.copyWith(
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Text(
          location.name.toString(),
          style: TextStyle(
              color: currentLocation != null
                  ? currentLocation!.name.toString() == location.name.toString()
                      ? kBaseColor
                      : Colors.black
                  : Colors.black),
        ),
      ),
    );
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
  Future<List<Location>?> getLocation() async {
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
        //setState(() {});
      }
    } else {
      showToast(kInternet);
    }
    return locations;
  }

  Location? selectedLocation;
  Location? currentLocation;
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
//    showToast("Player " + phoneNumber);
      PlayerData playerData = await apiCall.checkPlayer(mobile.toString());

      if (playerData.status!) {
        setState(() {
          player = playerData.player;
        });

//        getLocation();
        //  Utility.showToast("Player Found ${playerData.player!.image}");
      }
    }
  }

  void _showDialog() async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200.0,
                    width: 200.0,
                    child: Text("Loading..."),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  _dismissDialog() {
    Navigator.pop(context);
  }
}
