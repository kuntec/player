import 'package:flutter/material.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/participant_summary.dart';
import 'package:player/screens/payment_screen.dart';

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
              SizedBox(height: k20Margin),
              Text(
                "Event Name",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: kMargin),
              Text(
                widget.event.name,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                "Location",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: kMargin),
              Text(
                widget.event.address,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                "Organizer Name",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: kMargin),
              Text(
                widget.event.organizerName,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                "Contact Number",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: kMargin),
              Text(
                "${widget.event.number}",
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: kMargin),
              Text(
                "${widget.event.secondaryNumber}",
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                "Event Date",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: kMargin),
              Text(
                "${widget.event.startDate} to ${widget.event.endDate}",
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                "Event Time",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: kMargin),
              Text(
                "${widget.event.startTime} to ${widget.event.endTime}",
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                "Price",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: kMargin),
              Text(
                "\u{20B9} ${widget.event.entryFees} / ${widget.event.members} person",
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Container(
                margin: EdgeInsets.only(left: k20Margin, right: k20Margin),
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
