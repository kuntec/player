import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/services/servicewidgets/ServiceWidget.dart';

class HelperDetail extends StatefulWidget {
  dynamic service;

  HelperDetail({this.service});

  @override
  _HelperDetailState createState() => _HelperDetailState();
}

class _HelperDetailState extends State<HelperDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helper"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              posterImage2(context, widget.service.posterImage),
              SizedBox(height: kMargin),
              itemDetail(context, "Name", widget.service.name.toString()),
              itemCallDetail(context, "Contact Number",
                  widget.service.contactNo.toString()),
              itemCallDetail(context, "Secondary Number",
                  widget.service.secondaryNo.toString()),
              itemDetail(context, "Address", widget.service.address.toString()),
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
