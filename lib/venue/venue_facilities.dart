import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';

class VenueFacilities extends StatefulWidget {
  dynamic selectedF;

  VenueFacilities({this.selectedF});

  @override
  _VenueFacilitiesState createState() => _VenueFacilitiesState();
}

class _VenueFacilitiesState extends State<VenueFacilities> {
  List facilities = [
    "24/7",
    "Artificial Turf",
    "Ball Boy",
    "Cafe",
    "Drinking Water",
    "Flood Lights",
    "Locker Room",
    "Parking",
    "Rental Equipment",
    "Seating Lounge",
    "Showers",
    "Sound System",
    "Sport Shop",
    "Steam",
    "Walking Track",
    "Warm Up",
    "Washroom",
    "Air Conditioning",
    "Wi-Fi",
    "Coach",
  ];

  List facilityIcons = [
    "two.svg",
    "artificial_turf.svg",
    "ball_boy.svg",
    "cafe.svg",
    "drinking_water.svg",
    "flood_lights.svg",
    "locker_room.svg",
    "parking.svg",
    "rental_equipment.svg",
    "seating_lounge.svg",
    "shower.svg",
    "sound_system.svg",
    "sport_shop.svg",
    "steam.svg",
    "walking_track.svg",
    "warm_up.svg",
    "washroom.svg",
    "ac.svg",
    "wifi.svg",
    "coach.svg",
  ];

  List selectedFacilities = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedFacilities = widget.selectedF;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Select Venue Facilities",
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundedButton(
            color: kBaseColor,
            txtColor: Colors.white,
            minWidth: 250,
            title: "Save Selection",
            onPressed: () {
              Navigator.pop(context, selectedFacilities);
              //print(selectedFacilities);
              //Utility.showToast(selectedFacilities.toString());
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showFacilities(),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  showFacilities() {
    return Container(
      height: 700,
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 100),
          itemCount: facilities.length,
          itemBuilder: (BuildContext context, int index) {
            return facilityItem(facilities[index], index);
            // return ListTile(
            //     leading: Icon(Icons.list),
            //     trailing: Text(
            //       "GFG",
            //       style: TextStyle(color: Colors.green, fontSize: 15),
            //     ),
            //     title: Text("List item $index"));
          }),
    );
  }

  facilityItem(String item, int index) {
    return GestureDetector(
      onTap: () {
        for (int i = 0; i < selectedFacilities.length; i++) {
          if (selectedFacilities[i] == item) {
            print("Found double");
            selectedFacilities.remove(item);
            setState(() {});
            return;
          } else {}
        }
        selectedFacilities.add(item);
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        decoration: kContainerBoxDecoration.copyWith(
            color: selectedFacilities.any((element) => element == item)
                ? kBaseColor
                : Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                        "assets/images/${facilityIcons[index]}",
                        color:
                            selectedFacilities.any((element) => element == item)
                                ? Colors.white
                                : Colors.grey))),
            Expanded(
              flex: 8,
              child: Container(
                child: Text(
                  item,
                  style: TextStyle(
                      color:
                          selectedFacilities.any((element) => element == item)
                              ? Colors.white
                              : Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
