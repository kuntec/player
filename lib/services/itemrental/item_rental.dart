import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';

class ItemRental extends StatefulWidget {
  dynamic serviceId;

  ItemRental({this.serviceId});

  @override
  _ItemRentalState createState() => _ItemRentalState();
}

class _ItemRentalState extends State<ItemRental> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          "Item Rental",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //decoration: kServiceBoxItem,
              child: Text(
                "Coming Soon",
                style: TextStyle(
                    fontSize: 34,
                    color: kBaseColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
