import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_model.dart';
import 'package:player/model/service_photo.dart';
import 'package:player/services/personalcoach/personal_coach_details.dart';
import 'package:player/services/personalcoach/personal_coach_register.dart';
import 'package:player/services/physiofitness/physio_fitness_details.dart';
import 'package:player/services/physiofitness/physio_fitness_register.dart';
import 'package:player/services/scorer/scorer_details.dart';
import 'package:player/services/scorer/scorer_register.dart';
import 'package:player/services/service_photos.dart';
import 'package:player/services/sportmarket/sport_market_details.dart';
import 'package:player/services/sportmarket/sport_market_register.dart';
import 'package:player/services/umpire/umpire_details.dart';
import 'package:player/services/umpire/umpire_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPhysioFitness extends StatefulWidget {
  dynamic serviceId;
  MyPhysioFitness({this.serviceId});

  @override
  _MyPhysioFitnessState createState() => _MyPhysioFitnessState();
}

class _MyPhysioFitnessState extends State<MyPhysioFitness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Physio Fitness"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhysioFitnessRegister(
                        serviceId: widget.serviceId,
                      )));
        },
        backgroundColor: kBaseColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              allServiceData(),
            ],
          ),
        ),
      ),
    );
  }

  allServiceData() {
    return Container(
      height: 700,
      child: FutureBuilder(
        future: getServiceData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Loading....'),
              ),
            );
          }
          if (snapshot.hasData) {
            print("Has Data ${snapshot.data.length}");
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Data'),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 200),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return serviceItem(snapshot.data[index]);
              },
            );
          } else {
            return Container(
              child: Center(
                child: Text('No Data'),
              ),
            );
          }
        },
      ),
    );
  }

  List<Service>? services;

  Future<List<Service>?> getServiceData() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");
      ServiceModel serviceModel = await apiCall.getPlayerServiceData(
          widget.serviceId.toString(), playerId.toString());
      if (serviceModel.services != null) {
        services = serviceModel.services!;
      }

      if (serviceModel.status!) {
        //print(hostActivity.message!);
        //  Navigator.pop(context);
      } else {
        print(serviceModel.message!);
      }
    }
    return services;
  }

  Widget serviceItem(dynamic service) {
    return GestureDetector(
      onTap: () {
//        Utility.showToast(umpire.name.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhysioFitnessDetail(
              service: service,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
        // height: 200,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Utility.showToast("Show Dialog");
              },
              child: Container(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.more_horiz,
                  color: kBaseColor,
                  size: 25.0,
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    height: 80.0,
                    width: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        APIResources.IMAGE_URL + service.posterImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 110.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    service.name,
                    style: TextStyle(
                      color: kBaseColor,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Contact Number: ${service.contactNo}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Address: ${service.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "City: ${service.city}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}