import 'package:flutter/material.dart';

class TrophySeller extends StatefulWidget {
  const TrophySeller({Key? key}) : super(key: key);

  @override
  _TrophySellerState createState() => _TrophySellerState();
}

class _TrophySellerState extends State<TrophySeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Trophy Seller"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
