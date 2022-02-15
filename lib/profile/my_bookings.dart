import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/my_booking_data.dart';
import 'package:player/venue/booked_slot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBookings extends StatefulWidget {
  dynamic player;
  MyBookings({this.player});

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "My Bookings",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            myBookings(),
          ],
        ),
      ),
    );
  }

  myBookings() {
    return Container(
      height: 700,
      margin: EdgeInsets.all(10.0),
      child: FutureBuilder(
        future: getMyBookings(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Loading....'),
              ),
            );
          }
          if (snapshot.hasData) {
            print("Has Data ${snapshot.data.length}");
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Bookings'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 100),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return bookingItem(snapshot.data[index]);
                },
              );
            }
          } else {
            return Container(
              child: Center(
                child: Text('No Bookings'),
              ),
            );
          }
        },
      ),
    );
  }

  bookingItem(dynamic booking) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookedSlot(
                      booking: booking,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: kServiceBoxItem,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(
              "Name: ${booking.name}",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Number: ${booking.number}",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "No of Slots: ${booking.slots.length}",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Venue: ${booking.venue.name}",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Person allowed: ${booking.venue.members}",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Date: ${booking.createdAt}",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  List<Bookings>? bookings;

  Future<List<Bookings>?> getMyBookings() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");

      MyBookingData bookingData =
          await apiCall.getMyBookings(playerId.toString());
      if (bookingData.bookings != null) {
        bookings = bookingData.bookings!;
        bookings = bookings!.reversed.toList();

        //setState(() {});
      }
      if (bookingData.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(bookingData.message!);
      }
    }
    return bookings;
  }
}
