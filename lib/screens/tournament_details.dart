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
                  context, "Tournament Name", widget.tournament.tournamentName),
              itemDetail(context, "Address", widget.tournament.address),
              itemDetail(
                  context, "Contact Number", widget.tournament.organizerNumber),
              itemDetail(context, "Start Date", widget.tournament.startDate),
              itemDetail(context, "End Date", widget.tournament.endDate),
              itemDetail(context, "Entry Fees",
                  "\u{20B9} ${widget.tournament.entryFees}"),
              itemDetail(context, "Prize", widget.tournament.prizeDetails),
              itemDetail(
                  context, "Sport", widget.tournament.sportName.toString()),
              itemDetail(
                  context, "Status", widget.tournament.status.toString()),
              SizedBox(height: k20Margin),
              widget.tournament.status.toString() == "0"
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
                                      event: widget.tournament,
                                      isEvent: false)));
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
