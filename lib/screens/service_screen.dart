import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
          title: Text("SERVICES"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCard(Icons.store, "Sport Market"),
                  iconCard(Icons.school, "Academy"),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCard(Icons.people, "Umpires"),
                  iconCard(Icons.person, "Scorer"),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCard(Icons.speaker_phone, "Commentator"),
                  iconCard(Icons.wine_bar, "Item Rental"),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCard(Icons.store, "Trophy Sellers"),
                  iconCard(Icons.precision_manufacturing, "Manufacturers"),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCard(Icons.store, "T-Shirt Sellers"),
                  iconCard(Icons.person, "Personal Coach"),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCard(Icons.wine_bar, "Events"),
                  iconCard(Icons.person, "Physio and Fitness Trainer"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCard(IconData iconData, String title) {
    return Container(
      decoration: kContainerBoxDecoration,
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: kAppColor,
            size: 60,
          ),
          Center(
              child: Text(
            title,
            textAlign: TextAlign.center,
          ))
        ],
      ),
    );
  }
}
