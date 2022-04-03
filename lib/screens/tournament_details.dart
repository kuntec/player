import 'package:flutter/material.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/screens/participant_summary.dart';
import 'package:player/screens/payment_screen.dart';
import 'package:player/services/servicewidgets/ServiceWidget.dart';
import 'package:url_launcher/url_launcher.dart';

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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
            child: Text(
          "Tournament",
          style: TextStyle(color: Colors.black),
        )),
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
              Center(
                child: Container(
                  height: 150.0,
                  width: 150,
                  // width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      APIResources.IMAGE_URL + widget.tournament.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              widget.tournament.liveScoreLink == null
                  ? SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        //Utility.showToast("Live Score");
                        launch(widget.tournament.liveScoreLink);
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          margin: EdgeInsets.all(10),
                          height: 30,
                          width: 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.white,
                                size: 10,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "WATCH LIVE SCORE",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              // widget.tournament.liveScoreLink == null
              //     ? SizedBox.shrink()
              //     : itemLinkDetail(context, "Live Score Link",
              //         widget.tournament.liveScoreLink),
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
              itemDetail(
                  context,
                  "Entry Fees",
                  widget.tournament.entryFees == "0"
                      ? "Free"
                      : "\u{20B9} ${widget.tournament.entryFees}"),
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
              itemHelp(context),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
