import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_model.dart';
import 'package:player/services/my_service.dart';
import 'package:player/services/personalcoach/personal_coach_details.dart';
import 'package:player/services/physiofitness/my_physio_fitness.dart';
import 'package:player/services/physiofitness/physio_fitness_details.dart';
import 'package:player/services/physiofitness/physio_fitness_register.dart';
import 'package:player/services/scorer/scorer_register.dart';
import 'package:player/services/sportmarket/sport_market_register.dart';
import 'package:player/services/trophyseller/trophy_seller_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhysioFitness extends StatefulWidget {
  dynamic serviceId;

  PhysioFitness({this.serviceId});

  @override
  _PhysioFitnessState createState() => _PhysioFitnessState();
}

class _PhysioFitnessState extends State<PhysioFitness> {
  bool isService = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlayerService();
  }

  _refresh() {
    getPlayerService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Physio & Fitness",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (isService) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyPhysioFitness(
                                    serviceId: widget.serviceId,
                                  )));
                      _refresh();
                    } else {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhysioFitnessRegister(
                                    serviceId: widget.serviceId,
                                  )));
                      _refresh();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: kServiceBoxItem.copyWith(
                      color: kBaseColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          isService ? Icons.person : Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(width: 5),
                        Text(
                          isService ? "My Profile" : "Register",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ),
                // Center(
                //   child: TextButton.icon(
                //     onPressed: () {
                //       if (isService) {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => MyPhysioFitness(
                //                       serviceId: widget.serviceId,
                //                     )));
                //       } else {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => PhysioFitnessRegister(
                //                       serviceId: widget.serviceId,
                //                     )));
                //       }
                //     },
                //     icon: Icon(
                //       isService ? Icons.person : Icons.add,
                //       color: Colors.white,
                //     ),
                //     label: Text(
                //       isService ? "MyProfile" : "Register",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            allServiceData(),
          ],
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
      var locationId = prefs.get("locationId");
      ServiceModel serviceModel = await apiCall.getServiceDataId(
          widget.serviceId, "0", locationId.toString());
      if (serviceModel.services != null) {
        services = serviceModel.services!;
        services = services!.reversed.toList();
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
        margin: EdgeInsets.all(10.0),
//      padding: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
        // height: 200,
        child: Stack(
          children: [
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
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  SizedBox(height: 5.0),
                  Text(
                    "Experience: ${service.experience}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Address: ${service.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 14.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 7, bottom: 2),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Tap for details",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 10.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Service? service;
  Future getPlayerService() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");
      ServiceModel serviceModel = await apiCall.getPlayerServiceData(
          widget.serviceId.toString(), playerId.toString());
      if (serviceModel.services != null) {
        service = serviceModel.services!.first;
        print("First Service ${service!.contactNo}");
      }
      if (serviceModel.status!) {
        isService = true;
      } else {
        isService = false;
        print(serviceModel.message!);
      }
      setState(() {});
    }
  }
}
