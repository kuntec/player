import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/custom_button.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/venue_photo.dart';
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

  List selectedFacilities = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedFacilities = widget.venue.facilities.split(", ");
    print("Length : ${selectedFacilities.length}");
  }

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
          itemDetail(context, "Sport", widget.venue.sport.toString()),
          itemDetail(context, "Venue Name", widget.venue.name.toString()),
          widget.venue.description == null
              ? SizedBox.shrink()
              : itemDetail(context, "Venue Description",
                  widget.venue.description.toString()),
          itemDetail(context, "Open Time", widget.venue.openTime.toString()),
          itemDetail(context, "Close Time", widget.venue.closeTime.toString()),
          itemDetail(
              context, "Max Person Allowed", widget.venue.members.toString()),
          itemDetail(context, "Venue Address", widget.venue.address.toString()),
          widget.venue.locationLink == null ||
                  widget.venue.locationLink == "null"
              ? SizedBox.shrink()
              : itemDetail(context, "Location Link",
                  widget.venue.locationLink.toString()),
          itemDetail(context, "Venue City", widget.venue.city.toString()),
          widget.venue.facilities == null
              ? SizedBox.shrink()
              : itemDetail(
                  context, "Facilities", widget.venue.facilities.toString()),
          itemDetail(context, "Price",
              "\u{20B9} ${widget.venue.onwards.toString()} onwards"),
          SizedBox(height: k20Margin),
          RoundedButton(
              title: "Proceed To Book",
              color: kBaseColor,
              onPressed: () {
                //Utility.showToast("Venue ${widget.venue.id}");

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

  // showFacilities() {
  //   return Container(
  //     height: 400,
  //     child: ListView.builder(
  //         padding: EdgeInsets.only(bottom: 100),
  //         itemCount: selectedFacilities.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           return facilityItem(selectedFacilities[index], index);
  //           // return ListTile(
  //           //     leading: Icon(Icons.list),
  //           //     trailing: Text(
  //           //       "GFG",
  //           //       style: TextStyle(color: Colors.green, fontSize: 15),
  //           //     ),
  //           //     title: Text("List item $index"));
  //         }),
  //   );
  // }
  //
  // facilityItem(String item, int index) {
  //   return GestureDetector(
  //     onTap: () {},
  //     child: Container(
  //       margin: EdgeInsets.all(10.0),
  //       padding: EdgeInsets.all(10.0),
  //       decoration: kContainerBoxDecoration.copyWith(color: Colors.white),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Expanded(
  //               flex: 2,
  //               child: Container(
  //                   height: 30,
  //                   width: 30,
  //                   child: SvgPicture.asset(
  //                       facilities.any((element) => element == item)
  //                           ? "assets/images/${facilityIcons[facilities.indexOf(item)]}"
  //                           : "",
  //                       color: Colors.grey))),
  //           Expanded(
  //             flex: 8,
  //             child: Container(
  //               child: Text(
  //                 item,
  //                 style: TextStyle(color: Colors.grey),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget photoDetails() {
    return Container(
      child: Column(
        children: [
          myPhotos(),
        ],
      ),
    );
  }

  Widget myPhotos() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(20.0),
      child: FutureBuilder(
        future: getPhotos(),
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
            // return Container(
            //   child: Center(
            //     child: Text('Yes Data ${snapshot.data}'),
            //   ),
            // );
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Photos'),
                ),
              );
            } else {
              return GridView.builder(
                  padding: EdgeInsets.only(bottom: 250),
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return photoItem(snapshot.data[index]);
                  });
              // return ListView.builder(
              //   padding: EdgeInsets.only(bottom: 250),
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   itemCount: snapshot.data.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return photoItem(snapshot.data[index]);
              //   },
              // );
            }

            // return GridView.builder(
            //     itemCount: snapshot.data!.length,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2),
            //     itemBuilder: (context, index) {
            //       return photoItem(snapshot.data![index]);
            //     });
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

  List<Photos>? photos;

  Future<List<Photos>?> getPhotos() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      VenuePhoto venuePhoto =
          await apiCall.getVenuePhoto(widget.venue.id.toString());

      if (venuePhoto == null) {
        print("null");
      } else {
        if (venuePhoto.status!) {
          print("Success");
          //Utility.showToast("Timeslot Get Successfully");
          // timeslots!.clear();
          photos = venuePhoto.photos;
//          Navigator.pop(context);
        } else {
          print("Failed");
        }
      }
    }
    return photos;
  }

  photoItem(dynamic photo) {
    return GestureDetector(
      onTap: () {
        //Utility.showToast("Show Big Image");
        _showDialog(photo);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              height: 120.0,
              width: 120.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  APIResources.IMAGE_URL + photo.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(photo) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200.0,
                    width: 200.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Image.network(
                        APIResources.IMAGE_URL + photo.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // actions: <Widget>[
          //   TextButton(
          //       onPressed: () {
          //         _dismissDialog();
          //       },
          //       child: Text('Close')),
          // ],
        );
      },
    );
  }

  _dismissDialog() {
    Navigator.pop(context);
  }
}
