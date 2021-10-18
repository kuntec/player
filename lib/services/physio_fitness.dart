import 'package:flutter/material.dart';

class PhysioFitness extends StatefulWidget {
  const PhysioFitness({Key? key}) : super(key: key);

  @override
  _PhysioFitnessState createState() => _PhysioFitnessState();
}

class _PhysioFitnessState extends State<PhysioFitness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
        title: Text("Physio & Fitness"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
