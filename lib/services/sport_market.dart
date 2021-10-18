import 'package:flutter/material.dart';

class SportMarket extends StatefulWidget {
  const SportMarket({Key? key}) : super(key: key);

  @override
  _SportMarketState createState() => _SportMarketState();
}

class _SportMarketState extends State<SportMarket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Sport Market"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
