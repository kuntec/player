import 'package:flutter/material.dart';

class TshirtSeller extends StatefulWidget {
  const TshirtSeller({Key? key}) : super(key: key);

  @override
  _TshirtSellerState createState() => _TshirtSellerState();
}

class _TshirtSellerState extends State<TshirtSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("T-shirt Seller"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
