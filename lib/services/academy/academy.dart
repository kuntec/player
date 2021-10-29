import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_model.dart';
import 'package:player/services/academy/academy_detail.dart';
import 'package:player/services/academy/academy_register.dart';
import 'package:player/services/academy/my_academy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Academy extends StatefulWidget {
  dynamic serviceId;
  Academy({this.serviceId});

  @override
  _AcademyState createState() => _AcademyState();
}

class _AcademyState extends State<Academy> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlayerService();
  }

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
        title: Text("Academy"),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: kBaseColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            margin: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      if (isService) {
//                        Utility.showToast("Go To Service Profile");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAcademy(
                                      serviceId: widget.serviceId,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AcademyRegister(
                                      serviceId: widget.serviceId,
                                    )));
                      }
                    },
                    icon: Icon(
                      isService ? Icons.person : Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      isService ? "MyProfile" : "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
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
      padding: EdgeInsets.all(10.0),
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
      ServiceModel serviceModel =
          await apiCall.getServiceDataId(widget.serviceId);
      if (serviceModel.services != null) {
        services = serviceModel.services!;
        //setState(() {});
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
            builder: (context) => AcademyDetail(
              service: service,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
        width: MediaQuery.of(context).size.width,
        height: 120.0,
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
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kBaseColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                    )),
                                width: 100,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    service.sportName,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                ),
                              ),
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

  Widget serviceItem1(dynamic service) {
    return GestureDetector(
      onTap: () {
//        Utility.showToast(umpire.name.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AcademyDetail(
              service: service,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: kContainerBoxDecoration,
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

  Service? service;
  bool isService = false;
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
