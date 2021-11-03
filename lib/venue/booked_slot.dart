import 'package:flutter/material.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';

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
        title: Text("Booked Slots"),
      ),
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
      child: Text(slot.startTime.toString()),
    );
  }
}
