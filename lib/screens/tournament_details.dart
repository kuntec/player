import 'package:flutter/material.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/participant_summary.dart';
import 'package:player/screens/payment_screen.dart';
import 'package:player/services/servicewidgets/ServiceWidget.dart';

class TournamentDetails extends StatefulWidget {
  dynamic tournament;
  TournamentDetails({this.tournament});

  @override
  _TournamentDetailsState createState() => _TournamentDetailsState();
}

class _TournamentDetailsState extends State<TournamentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Tournament")),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBaseColor,
            )),
      ),
      bottomSheet: widget.tournament.status.toString() == "0"
          ? Container(
              margin: EdgeInsets.only(left: k20Margin, right: k20Margin),
              child: RoundedButton(
                title: "Booking Closed",
                color: kBaseColor,
                txtColor: Colors.white,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {},
              ),
            )
          : Container(
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
                              event: widget.tournament, isEvent: false)));
                },
              ),
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
                    APIResources.IMAGE_URL + widget.tournament.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              itemDetail(
                  context, "Sport", widget.tournament.sportName.toString()),
              widget.tournament.sportName.toString().toLowerCase() == "cricket"
                  ? itemDetail(context, "Tournament Category",
                      widget.tournament.tournamentCategory.toString())
                  : SizedBox.shrink(),
              widget.tournament.sportName.toString().toLowerCase() == "cricket"
                  ? widget.tournament.ballType == null
                      ? SizedBox.shrink()
                      : itemDetail(context, "Ball Type",
                          widget.tournament.ballType.toString())
                  : SizedBox.shrink(),
              widget.tournament.sportName.toString().toLowerCase() == "cricket"
                  ? itemDetail(context, "No of Overs",
                      widget.tournament.noOfOvers.toString())
                  : SizedBox.shrink(),
              itemDetail(
                  context, "Organizer Name", widget.tournament.organizerName),
              itemCallDetail(
                  context, "Primary Number", widget.tournament.organizerNumber),
              widget.tournament.secondaryNumber == null ||
                      widget.tournament.secondaryNumber == "null"
                  ? SizedBox.shrink()
                  : itemCallDetail(context, "Secondary Number",
                      widget.tournament.secondaryNumber),
              itemDetail(
                  context, "Tournament Name", widget.tournament.tournamentName),
              itemDetail(context, "Start Date", widget.tournament.startDate),
              itemDetail(context, "End Date", widget.tournament.endDate),
              itemDetail(context, "Entry Fees",
                  "\u{20B9} ${widget.tournament.entryFees}"),
              itemDetail(context, "Start Time", widget.tournament.startTime),
              itemDetail(context, "End Time", widget.tournament.endTime),
              widget.tournament.noOfMembers == null
                  ? SizedBox.shrink()
                  : itemDetail(context, "No of Team Members",
                      widget.tournament.noOfMembers),
              widget.tournament.ageLimit == null
                  ? SizedBox.shrink()
                  : itemDetail(
                      context, "Age Requirement", widget.tournament.ageLimit),
              itemDetail(
                  context, "Tournament Address", widget.tournament.address),
              widget.tournament.locationLink == null
                  ? SizedBox.shrink()
                  : itemLinkDetail(
                      context, "Location Link", widget.tournament.locationLink),
              widget.tournament.prizeDetails == null ||
                      widget.tournament.prizeDetails == "null"
                  ? SizedBox.shrink()
                  : itemDetail(
                      context, "Prize", widget.tournament.prizeDetails),
              widget.tournament.otherInfo == null ||
                      widget.tournament.otherInfo == "null"
                  ? SizedBox.shrink()
                  : itemDetail(context, "Other Information",
                      widget.tournament.otherInfo),
              SizedBox(height: 50),
              // widget.tournament.status.toString() == "0"
              //     ? Container(
              //         margin:
              //             EdgeInsets.only(left: k20Margin, right: k20Margin),
              //         child: RoundedButton(
              //           title: "Booking Closed",
              //           color: kBaseColor,
              //           txtColor: Colors.white,
              //           minWidth: MediaQuery.of(context).size.width,
              //           onPressed: () {},
              //         ),
              //       )
              //     : Container(
              //         margin:
              //             EdgeInsets.only(left: k20Margin, right: k20Margin),
              //         child: RoundedButton(
              //           title: "Proceed To Book",
              //           color: kBaseColor,
              //           txtColor: Colors.white,
              //           minWidth: MediaQuery.of(context).size.width,
              //           onPressed: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => ParticipantSummary(
              //                         event: widget.tournament,
              //                         isEvent: false)));
              //           },
              //         ),
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
