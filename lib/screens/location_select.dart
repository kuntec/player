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
  dynamic player;
  LocationSelectScreen({required this.player});
  @override
  _LocationSelectScreenState createState() => _LocationSelectScreenState();
}

class _LocationSelectScreenState extends State<LocationSelectScreen> {
  bool isLoading = false;

  String searchString = "";
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Location l = new Location();
    l.id = int.parse(widget.player.locationId);
    l.name = widget.player.city;
    selectedLocation = l;
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
                  widget.player!.locationId =
                      this.selectedLocation!.id.toString();
                  widget.player!.city = this.selectedLocation!.name.toString();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString(
                      "locationId", widget.player!.locationId.toString());
                  prefs.setString("city", widget.player!.city.toString());
                  await updatePlayer(widget.player);
                },
              ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: kServiceBoxItem,
                  margin: EdgeInsets.all(10),
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
              ),
              Expanded(flex: 9, child: myLocations()),
            ],
          ),
        ),
      ),
    ));
  }

  Widget myLocations() {
    return Container(
      height: 700,
      margin: EdgeInsets.all(10),
      child: FutureBuilder(
        future: getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Container(
                child: Text("Loading..."),
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
        // this.currentLocation = location;
        this.selectedLocation = location;
        setState(() {});
      },
      child: Container(
        decoration: kServiceBoxItem.copyWith(
          color: selectedLocation != null
              ? selectedLocation!.name.toString() == location.name.toString()
                  ? kBaseColor
                  : Colors.white
              : Colors.black,
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        child: Text(
          location.name.toString(),
          style: TextStyle(
              color: selectedLocation != null
                  ? selectedLocation!.name.toString() ==
                          location.name.toString()
                      ? Colors.white
                      : Colors.black
                  : Colors.black),
        ),
      ),
    );
  }

  updatePlayer(player) async {
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
      }
    } else {
      showToast(kInternet);
    }
    return locations;
  }

  Location? selectedLocation;
  // Widget buildLocationData(List<Location> location) {
  //   return DropdownButton<Location>(
  //     value: selectedLocation != null ? selectedLocation : null,
  //     hint: Text("Select Location"),
  //     isExpanded: true,
  //     icon: const Icon(Icons.keyboard_arrow_down),
  //     iconSize: 24,
  //     elevation: 16,
  //     style: const TextStyle(color: Colors.black),
  //     underline: Container(
  //       height: 2,
  //       color: kBaseColor,
  //     ),
  //     onChanged: (Location? newValue) {
  //       // this._selectedLK = newValue!;
  //       setState(() {
  //         this.selectedLocation = newValue!;
  //       });
  //     },
  //     items: location.map<DropdownMenuItem<Location>>((Location value) {
  //       return DropdownMenuItem<Location>(
  //         value: value,
  //         child: Text(value.name!),
  //       );
  //     }).toList(),
  //   );
  // }

  //
  // void _showDialog() async {
  //   return await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   height: 200.0,
  //                   width: 200.0,
  //                   child: Text("Loading..."),
  //                 ),
  //               ],
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // _dismissDialog() {
  //   Navigator.pop(context);
  // }
}
