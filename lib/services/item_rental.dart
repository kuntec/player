import 'package:flutter/material.dart';

class ItemRental extends StatefulWidget {
  const ItemRental({Key? key}) : super(key: key);

  @override
  _ItemRentalState createState() => _ItemRentalState();
}

class _ItemRentalState extends State<ItemRental> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text("Item Rental"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
