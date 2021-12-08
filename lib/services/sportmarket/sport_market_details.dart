import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/services/servicewidgets/ServiceWidget.dart';

class SportMarketDetail extends StatefulWidget {
  dynamic service;

  SportMarketDetail({this.service});

  @override
  _SportMarketDetailState createState() => _SportMarketDetailState();
}

class _SportMarketDetailState extends State<SportMarketDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sport Market"),
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
              itemDetail(context, "Address", widget.service.address.toString()),
              widget.service.locationLink == null
                  ? SizedBox.shrink()
                  : itemLinkDetail(context, "Address Link",
                      widget.service.locationLink.toString()),
              itemDetail(context, "City", widget.service.city.toString()),
              itemDetail(
                  context, "Owner Name", widget.service.contactName.toString()),
              itemCallDetail(context, "Contact Number",
                  widget.service.contactNo.toString()),
              widget.service.secondaryNo == null
                  ? SizedBox.shrink()
                  : itemCallDetail(context, "Secondary Number",
                      widget.service.secondaryNo.toString()),
              widget.service.about == null
                  ? SizedBox.shrink()
                  : itemDetail(context, "Details of Shop",
                      widget.service.about.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
