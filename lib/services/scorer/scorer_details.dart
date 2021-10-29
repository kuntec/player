import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/services/servicewidgets/ServiceWidget.dart';

class ScorerDetail extends StatefulWidget {
  dynamic service;

  ScorerDetail({this.service});

  @override
  _ScorerDetailState createState() => _ScorerDetailState();
}

class _ScorerDetailState extends State<ScorerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scorer"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              posterImage(context, widget.service.posterImage),
              SizedBox(height: kMargin),
              itemDetail(context, "Sport", widget.service.sportName.toString()),
              itemDetail(context, "Name", widget.service.name.toString()),
              itemCallDetail(context, "Contact Number",
                  widget.service.contactNo.toString()),
              itemCallDetail(context, "Secondary Number",
                  widget.service.secondaryNo.toString()),
              itemDetail(context, "City", widget.service.city.toString()),
              itemDetail(context, "Fees Per Match",
                  widget.service.feesPerMatch.toString()),
              itemDetail(context, "Fees Per Day",
                  widget.service.feesPerDay.toString()),
              itemDetail(context, "Scoring Experience",
                  widget.service.experience.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
