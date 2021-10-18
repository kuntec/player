import 'package:flutter/material.dart';

class Manufacturer extends StatefulWidget {
  const Manufacturer({Key? key}) : super(key: key);

  @override
  _ManufacturerState createState() => _ManufacturerState();
}

class _ManufacturerState extends State<Manufacturer> {
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
        title: Text("Manufacturer"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
