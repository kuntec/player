import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/add_venue_details.dart';

class AddVenue extends StatefulWidget {
  const AddVenue({Key? key}) : super(key: key);

  @override
  _AddVenueState createState() => _AddVenueState();
}

class _AddVenueState extends State<AddVenue> {
  bool? isMyVenueSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Venue")),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBaseColor,
            )),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.all(k20Margin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: kBaseColor,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddVenueDetails()));
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: k20Margin),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMyVenueSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabLeftDecoration.copyWith(
                            color:
                                isMyVenueSelected! ? Colors.white : kBaseColor),
                        child: Center(
                          child: Text(
                            "My Venue",
                            style: TextStyle(
                                color: isMyVenueSelected!
                                    ? kBaseColor
                                    : Colors.white,
                                fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMyVenueSelected = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabRightDecoration.copyWith(
                            color:
                                isMyVenueSelected! ? kBaseColor : Colors.white),
                        child: Center(
                          child: Text(
                            "Booking",
                            style: TextStyle(
                                color: isMyVenueSelected!
                                    ? Colors.white
                                    : kBaseColor,
                                fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isMyVenueSelected! ? myVenue() : addVenueForm(),
          ],
        ),
      ),
    );
  }

  myVenue() {
    return Container(
      child: Text("My Venue"),
    );
  }

  addVenueForm() {
    return Container(
      child: Text("Add Venue"),
    );
  }
}
