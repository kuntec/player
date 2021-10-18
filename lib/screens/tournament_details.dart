import 'package:flutter/material.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/payment_screen.dart';

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
              SizedBox(height: k20Margin),
              Text(
                "Tournament Name",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                widget.tournament.tournamentName,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                "Location",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                widget.tournament.address,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                "Contact Number",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                widget.tournament.organizerNumber,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                "Tournament Date",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                widget.tournament.startDate,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                "Price",
                style: TextStyle(color: kBaseColor, fontSize: 16.0),
              ),
              SizedBox(height: k20Margin),
              Text(
                widget.tournament.prizeDetails,
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
                            builder: (context) => PaymentScreen()));
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
