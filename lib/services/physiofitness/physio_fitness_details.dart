import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/services/servicewidgets/ServiceWidget.dart';

class PhysioFitnessDetail extends StatefulWidget {
  dynamic service;

  PhysioFitnessDetail({this.service});

  @override
  _PhysioFitnessDetailState createState() => _PhysioFitnessDetailState();
}

class _PhysioFitnessDetailState extends State<PhysioFitnessDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Physio Fitness"),
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
              itemDetail(context, "Name", widget.service.name.toString()),
              itemCallDetail(context, "Contact Number",
                  widget.service.contactNo.toString()),
              itemCallDetail(context, "Secondary Number",
                  widget.service.secondaryNo.toString()),
              itemCallDetail(
                  context, "Address", widget.service.address.toString()),
              itemDetail(context, "City", widget.service.city.toString()),
              itemDetail(
                  context, "Experience", widget.service.experience.toString()),
              itemDetail(context, "Additional Details",
                  widget.service.about.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
