import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_data.dart';
import 'package:player/model/service_model.dart';
import 'package:player/services/academy/academy_detail.dart';
import 'package:player/services/academy/academy_register.dart';
import 'package:player/services/academy/edit_academy.dart';
import 'package:player/services/service_photos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAcademy extends StatefulWidget {
  dynamic serviceId;
  MyAcademy({this.serviceId});

  @override
  _MyAcademyState createState() => _MyAcademyState();
}

class _MyAcademyState extends State<MyAcademy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Academy"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AcademyRegister(
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

  var selectedService;
  Widget serviceItem(dynamic service) {
    return GestureDetector(
      onTap: () {
        Utility.showToast("Service id ${service.id}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServicePhotos(
              serviceDataId: service.id,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
        width: MediaQuery.of(context).size.width,
        height: 135.0,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
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
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  service.name,
                                  style: TextStyle(
                                    color: kBaseColor,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  selectedService = service;
                                  showCupertinoDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: createDialog,
                                  );
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
                              // child: Container(
                              //   decoration: BoxDecoration(
                              //       color: kBaseColor,
                              //       borderRadius: BorderRadius.only(
                              //         topRight: Radius.circular(10.0),
                              //         bottomLeft: Radius.circular(10.0),
                              //       )),
                              //   width: 100,
                              //   height: 40,
                              //   child: Center(
                              //     child: Text(
                              //       service.sportName,
                              //       style: TextStyle(
                              //           color: Colors.white, fontSize: 12.0),
                              //     ),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
        title: Text("Choose an option"),
        // content: Text("Message"),
        actions: [
          CupertinoDialogAction(
            child: Text(
              "Edit",
              style: TextStyle(color: kBaseColor),
            ),
            onPressed: () async {
              Navigator.pop(context);

              var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditAcademy(
                            service: selectedService,
                          )));
              if (result == true) {
                _refresh();
              }
            },
          ),
          CupertinoDialogAction(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              Navigator.pop(context);
              await deleteService(selectedService.id.toString());
            },
          ),
          CupertinoDialogAction(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );

  _refresh() {
    setState(() {});
  }

  deleteService(String id) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      ServiceData serviceData = await apiCall.deleteService(id);
      if (serviceData.status!) {
        Utility.showToast(serviceData.message.toString());
        _refresh();
      } else {
        print(serviceData.message!);
      }
    }
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
}
