import 'package:flutter/material.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/participant_summary.dart';
import 'package:player/screens/payment_screen.dart';
import 'package:player/services/servicewidgets/ServiceWidget.dart';

class EventDetails extends StatefulWidget {
  dynamic event;
  EventDetails({this.event});

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Event")),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBaseColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    APIResources.IMAGE_URL + widget.event.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              itemDetail(context, "Event Name", widget.event.name),
              itemDetail(context, "Event Type", widget.event.type),
              itemDetail(context, "Date",
                  "${widget.event.startDate} to ${widget.event.endDate}"),
              itemDetail(context, "Time",
                  "${widget.event.startTime} to ${widget.event.endTime}"),
              itemDetail(context, "Entry Fees",
                  "\u{20B9} ${widget.event.entryFees} / ${widget.event.members} person"),
              itemDetail(context, "Address", widget.event.address),
              itemLinkDetail(
                  context, "Location Link", widget.event.locationLink),
              itemDetail(context, "Organizer Name", widget.event.organizerName),
              itemCallDetail(context, "Contact Number", widget.event.number),
              itemCallDetail(
                  context, "Secondary Number", widget.event.secondaryNumber),
              itemDetail(context, "Description", widget.event.description),
              itemDetail(context, "Details", widget.event.details),
              SizedBox(height: k20Margin),
              widget.event.status.toString() == "0"
                  ? Container(
                      margin:
                          EdgeInsets.only(left: k20Margin, right: k20Margin),
                      child: RoundedButton(
                        title: "Booking Closed",
                        color: kBaseColor,
                        txtColor: Colors.white,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {},
                      ),
                    )
                  : Container(
                      margin:
                          EdgeInsets.only(left: k20Margin, right: k20Margin),
                      child: RoundedButton(
                        title: "Proceed To Book",
                        color: kBaseColor,
                        txtColor: Colors.white,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ParticipantSummary(
                                      event: widget.event, isEvent: true)));
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
