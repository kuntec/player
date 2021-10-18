import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';

class TournamentParticipants extends StatefulWidget {
  dynamic tournamentId;
  TournamentParticipants({this.tournamentId});

  @override
  _TournamentParticipantsState createState() => _TournamentParticipantsState();
}

class _TournamentParticipantsState extends State<TournamentParticipants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Host Tournament")),
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
        child: Column(
          children: [
            Text("Participants name and payment mode ${widget.tournamentId}")
          ],
        ),
      ),
    );
  }
}
