import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_data.dart';
import 'package:player/services/academy/academy.dart';
import 'package:player/services/commentator/commentator.dart';
import 'package:player/services/helper/helper.dart';
import 'package:player/services/itemrental/item_rental.dart';
import 'package:player/services/manufacturer/manufacturer.dart';
import 'package:player/services/organiser.dart';
import 'package:player/services/personalcoach/personal_coach.dart';
import 'package:player/services/physiofitness/physio_fitness.dart';
import 'package:player/services/scorer/scorer.dart';
import 'package:player/services/sportmarket/sport_market.dart';
import 'package:player/services/trophyseller/trophy_seller.dart';
import 'package:player/services/tshirtseller/tshirt_seller.dart';
import 'package:player/services/umpire/umpire.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen>
    with AutomaticKeepAliveClientMixin<ServiceScreen> {
  @override
  bool get wantKeepAlive => true;

  String selectedServiceId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final serviceMdl = Provider.of<ServiceModel>(context, listen: false);
    // services = serviceMdl.getServiceData(context);
  }

  // List serviceScreens = [
  //   PersonalCoach(),
  //   TrophySeller(),
  //   Manufacturer(),
  //   Scorer(),
  //   Organiser(),
  //   Academy(),
  //   TshirtSeller(),
  //   SportMarket(),
  //   Umpire(),
  //   PhysioFitness(),
  //   Commentator(),
  //   Helper(),
  //   ItemRental(),
  // ];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "SERVICES",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: k20Margin,
              // ),
              // Center(
              //   child: Text(
              //     "Choose Your Service  ",
              //     style: const TextStyle(
              //       color: kBaseColor,
              //       fontStyle: FontStyle.normal,
              //       fontSize: 30.0,
              //     ),
              //     textAlign: TextAlign.left,
              //   ),
              // ),
              // SizedBox(
              //   height: 10.0,
              // ),
              Container(
                height: 700,
                child: FutureBuilder<List<Services>?>(
                  future: getService(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          padding: EdgeInsets.only(bottom: 200),
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return serviceCard(snapshot.data![index]);
                          });
                    } else if (snapshot.hasError) {
                      return Text("Error");
                    }
                    return Center(
                      child: Container(
                          child: CircularProgressIndicator(color: kBaseColor)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceCard(dynamic service) {
    return GestureDetector(
      onTap: () {
        print("Service Selected ${service.id}");
        int index = service.id;
        selectedServiceId = service.id.toString();

        switch (index) {
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PersonalCoach(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 2:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TrophySeller(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 3:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Manufacturer(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 4:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scorer(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 5:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Organiser(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 6:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Academy(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 7:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TshirtSeller(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 8:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SportMarket(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 9:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Umpire(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 10:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PhysioFitness(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 11:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Commentator(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 12:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Helper(
                          serviceId: selectedServiceId,
                        )));
            break;
          case 13:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemRental(
                          serviceId: selectedServiceId,
                        )));
            break;
        }
      },
      child: Container(
        decoration: kContainerBoxDecoration.copyWith(
          color: kBaseColor,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: kBaseColor,
            width: 1.0,
          ),
        ),
        height: 80,
        width: 80,
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  service.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image(
                image: NetworkImage(APIResources.IMAGE_URL + service.icon),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<Services>> getService() async {
    APICall apiCall = new APICall();
    List<Services> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      //ServiceData serviceData = await apiCall.getService();
      ServiceData serviceData = ServiceData.fromJson(jsonDecode(kServices));
      if (serviceData.services != null) {
        data.addAll(serviceData.services!);
      }
    } else {}
    return data;
  }

  getLocalService() async {
    return ServiceData.fromJson(jsonDecode(kServices));
  }
}
