import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_photo.dart';
import 'package:player/services/servicewidgets/ServiceWidget.dart';

class TshirtSellerDetails extends StatefulWidget {
  dynamic service;
  TshirtSellerDetails({this.service});

  @override
  _TshirtSellerDetailsState createState() => _TshirtSellerDetailsState();
}

class _TshirtSellerDetailsState extends State<TshirtSellerDetails> {
  bool? isPhotoSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Tshirt Seller Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: kMargin),
              posterImage2(context, widget.service.posterImage),
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
          itemDetail(context, "Name", widget.service.name.toString()),
          itemDetail(context, "Address", widget.service.address.toString()),
          widget.service.locationLink == null
              ? SizedBox.shrink()
              : itemLinkDetail(context, "Address Link",
                  widget.service.locationLink.toString()),
          itemDetail(context, "City", widget.service.city.toString()),
          itemDetail(
              context, "Owner Name", widget.service.contactName.toString()),
          itemCallDetail(
              context, "Contact Number", widget.service.contactNo.toString()),
          widget.service.secondaryNo == null
              ? SizedBox.shrink()
              : itemCallDetail(context, "Secondary Number",
                  widget.service.secondaryNo.toString()),
          widget.service.about == null
              ? SizedBox.shrink()
              : itemDetail(
                  context, "About Academy", widget.service.about.toString()),
          itemHelp(context),
        ],
      ),
    );
  }

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
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return photoItem(snapshot.data![index]);
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
      print("Getting Photos of ${widget.service.id.toString()}");
      ServicePhoto servicePhoto =
          await apiCall.getServicePhoto(widget.service.id.toString());

      if (servicePhoto == null) {
        print("Photos null");
      } else {
        if (servicePhoto.status!) {
          print("Photos Success");
          photos = servicePhoto.photos;
        } else {
          print("Photos Failed");
        }
      }
    }
    return photos;
  }

  photoItem(dynamic photo) {
    return Container(
//      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Container(
            height: 115.0,
            width: 115.0,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(
                APIResources.IMAGE_URL + photo.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
