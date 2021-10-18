import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_data.dart';
import 'package:player/services/academy.dart';
import 'package:player/services/commentator.dart';
import 'package:player/services/helper.dart';
import 'package:player/services/item_rental.dart';
import 'package:player/services/manufacturer.dart';
import 'package:player/services/organiser.dart';
import 'package:player/services/personal_coach.dart';
import 'package:player/services/physio_fitness.dart';
import 'package:player/services/scorer.dart';
import 'package:player/services/sport_market.dart';
import 'package:player/services/trophy_seller.dart';
import 'package:player/services/tshirt_seller.dart';
import 'package:player/services/umpire.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  List serviceScreens = [
    PersonalCoach(),
    TrophySeller(),
    Manufacturer(),
    Scorer(),
    Organiser(),
    Academy(),
    TshirtSeller(),
    SportMarket(),
    Umpire(),
    PhysioFitness(),
    Commentator(),
    Helper(),
    ItemRental(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
//        leading: Icon(Icons.arrow_back),
          title: Text("SERVICES"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: k20Margin,
              ),
              Center(
                child: Text(
                  "Choose Your Service",
                  style: const TextStyle(
                    color: kBaseColor,
                    fontStyle: FontStyle.normal,
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 700,
                child: FutureBuilder<List<Services>>(
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
                    return Text("Loading...");
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     iconCard(Icons.store, "Sport Market"),
              //     iconCard(Icons.school, "Academy"),
              //   ],
              // ),
              // SizedBox(height: 20.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     iconCard(Icons.people, "Umpires"),
              //     iconCard(Icons.person, "Scorer"),
              //   ],
              // ),
              // SizedBox(height: 20.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     iconCard(Icons.speaker_phone, "Commentator"),
              //     iconCard(Icons.wine_bar, "Item Rental"),
              //   ],
              // ),
              // SizedBox(height: 20.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     iconCard(Icons.store, "Trophy Sellers"),
              //     iconCard(Icons.precision_manufacturing, "Manufacturers"),
              //   ],
              // ),
              // SizedBox(height: 20.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     iconCard(Icons.store, "T-Shirt Sellers"),
              //     iconCard(Icons.person, "Personal Coach"),
              //   ],
              // ),
              // SizedBox(height: 20.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     iconCard(Icons.wine_bar, "Events"),
              //     iconCard(Icons.person, "Physio and Fitness Trainer"),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget iconCard(IconData iconData, String title) {
  //   return Container(
  //     decoration: kContainerBoxDecoration,
  //     height: 100,
  //     width: 100,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         Icon(
  //           iconData,
  //           color: kAppColor,
  //           size: 60,
  //         ),
  //         Center(
  //             child: Text(
  //           title,
  //           textAlign: TextAlign.center,
  //         ))
  //       ],
  //     ),
  //   );
  // }

  Widget serviceCard(dynamic service) {
    return GestureDetector(
      onTap: () {
        print("Service Selected ${service.id}");
        int index = service.id - 1;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => serviceScreens[index]));
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
      ServiceData serviceData = await apiCall.getService();

      if (serviceData.services != null) {
        data.addAll(serviceData.services!);
      }
    } else {}
    return data;
  }
}
