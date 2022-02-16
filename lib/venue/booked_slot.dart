import 'package:flutter/material.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/custom_button.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';

class BookedSlot extends StatefulWidget {
  dynamic booking;
  BookedSlot({this.booking});

  @override
  _BookedSlotState createState() => _BookedSlotState();
}

class _BookedSlotState extends State<BookedSlot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Booked Slots",
          style: TextStyle(color: Colors.black),
        ),
      ),
      // bottomSheet: Container(
      //   margin: EdgeInsets.only(left: k20Margin, right: k20Margin),
      //   child: RoundedButton(
      //       title: "Cancel Booking",
      //       color: kBaseColor,
      //       onPressed: () {
      //         _showDialog();
      //       },
      //       minWidth: MediaQuery.of(context).size.width,
      //       txtColor: Colors.white),
      //
      //
      // ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                decoration: kServiceBoxItem.copyWith(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: 140.0,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    APIResources.IMAGE_URL + widget.booking.venue.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: k20Margin),
              buildTimeSlot2(),
            ],
          ),
        ),
      ),
    );
  }

  buildTimeSlot2() {
    return widget.booking.slots!.length == 0
        ? Container(
            margin: EdgeInsets.all(20.0),
            child: Text("No TimeSlot Found on this Day"),
          )
        : Container(
            margin: EdgeInsets.only(top: 10.0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.booking.slots!.length,
                itemBuilder: (context, index) {
                  return slotItem(widget.booking.slots![index], index);
                }),
            // child: GridView.builder(
            //     itemCount: widget.bookedTimeSlots!.length,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3),
            //     itemBuilder: (context, index) {
            //       return slotItem(widget.bookedTimeSlots![index], index);
            //     }),
          );
  }

  slotItem(dynamic slot, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: kServiceBoxItem.copyWith(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date : ${slot.bookingDate.toString()}"),
          SizedBox(height: 5),
          Text("Start Time : ${slot.startTime.toString()}"),
          SizedBox(height: 5),
          Text("Price : \u{20B9} ${slot.price.toString()}"),
        ],
      ),
    );
  }

  void _showDialog() async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: kBaseColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      "Cancel Booking",
                      style: TextStyle(fontSize: 24.0, color: kBaseColor),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "For cancellation please contact the organizer",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Name ${widget.booking.owner.name}",
                      style: TextStyle(fontSize: 16.0, color: Colors.black54),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Number ${widget.booking.owner.mobile}",
                      style: TextStyle(fontSize: 16.0, color: Colors.black54),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Utility.launchCall(widget.booking.owner.mobile);
                      },
                      child: CircleAvatar(
                        backgroundColor: kBaseColor,
                        radius: 35,
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                    // SizedBox(height: 40),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  _dismissDialog();
                },
                child: Text('Close')),
          ],
        );
      },
    );
  }

  _dismissDialog() {
    Navigator.pop(context);
  }
}
