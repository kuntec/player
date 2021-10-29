import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/services/service_photos.dart';

class MyService extends StatefulWidget {
  final service;
  MyService({required this.service});

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Service"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedButton(
                  title: "Manage Photos",
                  color: kBaseColor,
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ServicePhotos(
                    //               serviceId: widget.service.id.toString(),
                    //             )));
                  },
                  minWidth: 150,
                  txtColor: Colors.white),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
