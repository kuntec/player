import 'package:flutter/material.dart';

class EditSportMarket extends StatefulWidget {
  const EditSportMarket({Key? key}) : super(key: key);

  @override
  _EditSportMarketState createState() => _EditSportMarketState();
}

class _EditSportMarketState extends State<EditSportMarket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Sport Market"),
      ),
    );
  }
}
