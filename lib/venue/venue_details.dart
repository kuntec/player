import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_photo.dart';
import 'package:player/services/servicewidgets/ServiceWidget.dart';
import 'package:player/venue/book_time_slot.dart';

class VenueDetails extends StatefulWidget {
  dynamic venue;
  VenueDetails({this.venue});

  @override
  _VenueDetailsState createState() => _VenueDetailsState();
}

class _VenueDetailsState extends State<VenueDetails> {
  bool? isPhotoSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venue"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: kServiceBoxItem.copyWith(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: 140.0,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    APIResources.IMAGE_URL + widget.venue.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: k20Margin),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPhotoSelected = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: kContainerTabLeftDecoration.copyWith(
                              color:
                                  isPhotoSelected! ? Colors.white : kBaseColor),
                          child: Center(
                            child: Text(
                              "Details",
                              style: TextStyle(
                                  color: isPhotoSelected!
                                      ? kBaseColor
                                      : Colors.white,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPhotoSelected = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: kContainerTabRightDecoration.copyWith(
                              color:
                                  isPhotoSelected! ? kBaseColor : Colors.white),
                          child: Center(
                            child: Text(
                              "More Photos",
                              style: TextStyle(
                                  color: isPhotoSelected!
                                      ? Colors.white
                                      : kBaseColor,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isPhotoSelected! ? photoDetails() : details()
            ],
          ),
        ),
      ),
    );
  }

  Widget details() {
    return Container(
      child: Column(
        children: [
          itemDetail(context, "Venue Name", widget.venue.name.toString()),
          itemDetail(
              context, "Venue Location", widget.venue.address.toString()),
          // itemDetail(
          //     context, "Contact Number", widget.venue.contactNo.toString()),
          // itemDetail(context, "Address", widget.service.address.toString()),
          // itemDetail(
          //     context, "Address Link", widget.service.locationLink.toString()),
          // itemDetail(context, "City", widget.service.city.toString()),
          // itemDetail(
          //     context, "Owner Name", widget.service.contactName.toString()),
          // itemCallDetail(
          //     context, "Contact Number", widget.service.contactNo.toString()),
          // itemCallDetail(context, "Secondary Number",
          //     widget.service.secondaryNo.toString()),
          // itemDetail(context, "About Academy", widget.service.about.toString()),
          SizedBox(height: k20Margin),
          RoundedButton(
              title: "Proceed To Book",
              color: kBaseColor,
              onPressed: () {
                Utility.showToast("Venue ${widget.venue.id}");

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookTimeSlot(
                              venue: widget.venue,
                            )));
              },
              minWidth: 250,
              txtColor: Colors.white),
        ],
      ),
    );
  }

  Widget photoDetails() {
    return Container(
      child: Column(
        children: [
          //  myPhotos(),
        ],
      ),
    );
  }
//
//   Widget myPhotos() {
//     return Container(
//       height: 700,
//       padding: EdgeInsets.all(20.0),
//       child: FutureBuilder(
//         future: getPhotos(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return Container(
//               child: Center(
//                 child: Text('Loading....'),
//               ),
//             );
//           }
//           if (snapshot.hasData) {
//             print("Has Data ${snapshot.data.length}");
//             // return Container(
//             //   child: Center(
//             //     child: Text('Yes Data ${snapshot.data}'),
//             //   ),
//             // );
//             if (snapshot.data.length == 0) {
//               return Container(
//                 child: Center(
//                   child: Text('No Photos'),
//                 ),
//               );
//             } else {
//               return GridView.builder(
//                   itemCount: snapshot.data!.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2),
//                   itemBuilder: (context, index) {
//                     return photoItem(snapshot.data![index]);
//                   });
//
//               // return ListView.builder(
//               //   padding: EdgeInsets.only(bottom: 250),
//               //   scrollDirection: Axis.vertical,
//               //   shrinkWrap: true,
//               //   itemCount: snapshot.data.length,
//               //   itemBuilder: (BuildContext context, int index) {
//               //     return photoItem(snapshot.data[index]);
//               //   },
//               // );
//             }
//           } else {
//             return Container(
//               child: Center(
//                 child: Text('No Data'),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   List<Photos>? photos;
//
//   Future<List<Photos>?> getPhotos() async {
//     APICall apiCall = new APICall();
//     bool connectivityStatus = await Utility.checkConnectivity();
//     if (connectivityStatus) {
//       ServicePhoto servicePhoto =
//           await apiCall.getServicePhoto(widget.service.id.toString());
//
//       if (servicePhoto == null) {
//         print("Photos null");
//       } else {
//         if (servicePhoto.status!) {
//           print("Photos Success");
//           photos = servicePhoto.photos;
//         } else {
//           print("Photos Failed");
//         }
//       }
//     }
//     return photos;
//   }
//
//   photoItem(dynamic photo) {
//     return Container(
// //      margin: EdgeInsets.only(bottom: 10),
//       child: Column(
//         children: [
//           Container(
//             height: 115.0,
//             width: 115.0,
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               child: Image.network(
//                 APIResources.IMAGE_URL + photo.image,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}
