import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/my_sport.dart';
import 'package:player/model/service_model.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/services/commentator/commentator_details.dart';
import 'package:player/services/commentator/commentator_register.dart';
import 'package:player/services/commentator/my_commentator.dart';
import 'package:player/services/my_service.dart';
import 'package:player/services/scorer/scorer_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Commentator extends StatefulWidget {
  dynamic serviceId;

  Commentator({this.serviceId});

  @override
  _CommentatorState createState() => _CommentatorState();
}

class _CommentatorState extends State<Commentator> {
  bool isService = false;
  List<Sports> sports = [];
  List<Data> allSports = [];
  var selectedSportId = "0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMySports();
    getSports();
    getPlayerService();
  }

  _refresh() {
    getPlayerService();
  }

  Future<List<Sports>> getMySports() async {
    APICall apiCall = new APICall();
    // List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var playerId = prefs.get("playerId");
      MySport mySport = await apiCall.getMySports(playerId.toString());

      if (mySport.sports != null) {
        Sports s = new Sports();
        s.sportName = "All";
        s.sportId = "0";
        sports.clear();
        sports.add(s);
        sports.addAll(mySport.sports!);
        Sports s2 = new Sports();
        s2.sportName = "Others";
        s2.sportId = null;
        sports.add(s2);
        setState(() {});
      }
    } else {}
    return sports;
  }

  Future<List<Data>> getSports() async {
    APICall apiCall = new APICall();
    List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SportData sportData = await apiCall.getSports();

      if (sportData.data != null) {
        data.addAll(sportData.data!);
        allSports = data;
      }
    } else {}
    return data;
  }

  Widget sportBarList() {
    return sports != null
        ? Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                )
              ],
            ),
            height: 50,
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sports.length,
                itemBuilder: (BuildContext context, int index) {
                  return sportChip(sports[index]);
                },
              ),
            ),
          )
        : Container();
  }

  Widget sportChip(sport) {
    return GestureDetector(
      onTap: () {
        if (sport.sportId == null) {
          sports.removeLast();
          for (int i = 0; i < allSports.length; i++) {
            bool status = false;
            for (int j = 0; j < sports.length; j++) {
              // print("Checking for ${allSports[i].sportName}");
              if (allSports[i].sportName == sports[j].sportName) {
                status = false;
                // print("Found ${allSports[i].sportName}");
                break;
              } else {
                status = true;
                //  print("Not Found ${allSports[i].sportName}");
              }
            }
            if (status) {
              print("Sport Name ${allSports[i].sportName}");
              Sports s = new Sports();
              s.sportName = allSports[i].sportName;
              s.sportId = allSports[i].id.toString();
              sports.add(s);
            }
          }
        } else {
          selectedSportId = sport.sportId.toString();
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            width: 1.0,
            color: sport.sportId.toString() == selectedSportId
                ? kBaseColor
                : Colors.white,
          ),
          color: sport.sportId.toString() == selectedSportId
              ? kBaseColor
              : Colors.white,
        ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            sport.sportName,
            style: TextStyle(
                color: sport.sportId.toString() == selectedSportId
                    ? Colors.white
                    : Colors.black,
                fontSize: 12.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Commentator",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (isService) {
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyCommentator(
                                    serviceId: widget.serviceId,
                                  )));
                      _refresh();
                    } else {
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentatorRegister(
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
            sportBarList(),
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var locationId = prefs.get("locationId");
      ServiceModel serviceModel = await apiCall.getServiceDataId(
          widget.serviceId, selectedSportId.toString(), locationId.toString());
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
            builder: (context) => CommentatorDetail(
              service: service,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
        width: MediaQuery.of(context).size.width,
        height: 100.0,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  service.name,
                                  style: TextStyle(
                                    color: kBaseColor,
                                    fontSize: 16.0,
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
                                      topRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                    )),
                                width: 80,
                                height: 30,
                                child: Center(
                                  child: Text(
                                    service.sportName,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.0),
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
                          //margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Experience: ${service.experience}",
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
            ),
          ],
        ),
      ),
    );
  }

//   Widget serviceItem(dynamic service) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CommentatorDetail(
//               service: service,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.all(10.0),
// //      padding: EdgeInsets.only(bottom: 10.0),
//         decoration: kServiceBoxItem,
//         // height: 200,
//         child: Stack(
//           children: [
//             Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.all(10.0),
//                     height: 80.0,
//                     width: 80.0,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       child: Image.network(
//                         APIResources.IMAGE_URL + service.posterImage,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 110.0, right: 5.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 10.0),
//                   Text(
//                     service.name,
//                     style: TextStyle(
//                         color: kBaseColor,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 5.0),
//                   Text(
//                     "Contact: ${service.contactNo}",
//                     style: TextStyle(
//                       color: Colors.grey.shade900,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                   SizedBox(height: 5.0),
//                   Text(
//                     "City: ${service.city}",
//                     style: TextStyle(
//                       color: Colors.grey.shade900,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

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
