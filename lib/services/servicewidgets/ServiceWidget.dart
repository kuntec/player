import 'package:flutter/cupertino.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/service_model.dart';
import 'package:player/services/service_photos.dart';
import 'package:url_launcher/url_launcher.dart';

Widget itemLinkDetail(BuildContext context, String title, String value) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: kMargin),
        Text(
          title,
          style: TextStyle(color: kBaseColor, fontSize: 16.0),
        ),
        SizedBox(height: kMargin),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
              )
            ],
          ),
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: () {
              launch(value);
            },
            child: Text(
              value,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                  fontSize: 16.0),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget itemDetail(BuildContext context, String title, String value) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: kMargin),
        Text(
          title,
          style: TextStyle(color: kBaseColor, fontSize: 16.0),
        ),
        SizedBox(height: kMargin),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
              )
            ],
          ),
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          child: Text(
            value,
            style: TextStyle(color: kBlack, fontSize: 16.0),
          ),
        ),
      ],
    ),
  );
}

Widget itemCallDetail(BuildContext context, String title, String value) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: kMargin),
        Text(
          title,
          style: TextStyle(color: kBaseColor, fontSize: 16.0),
        ),
        SizedBox(height: kMargin),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
              )
            ],
          ),
          padding: EdgeInsets.all(5.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              GestureDetector(
                onTap: () {
                  Utility.launchCall(value);
                },
                child: Icon(
                  Icons.call,
                  color: kBaseColor,
                  size: 25.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget posterImage(BuildContext context, String url) {
  return Container(
    decoration: kServiceBoxItem.copyWith(
      borderRadius: BorderRadius.circular(5.0),
    ),
    height: 100.0,
    width: MediaQuery.of(context).size.width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        APIResources.IMAGE_URL + url,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget posterImage2(BuildContext context, String url) {
  return Container(
    decoration: kServiceBoxItem.copyWith(
      borderRadius: BorderRadius.circular(5.0),
    ),
    height: 150.0,
    width: 150,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        APIResources.IMAGE_URL + url,
        fit: BoxFit.fill,
      ),
    ),
  );
}

// addService(BuildContext context, String filePath, Service service) async {
//   APICall apiCall = new APICall();
//   bool connectivityStatus = await Utility.checkConnectivity();
//   if (connectivityStatus) {
//     ServiceModel serviceModel = await apiCall.addServiceData(filePath, service);
//     if (!serviceModel.status!) {
//       print("null");
//       Utility.showToast("Failed");
//     } else {
//       print("Success");
//       Utility.showToast("Service Created Successfully");
//       var result = Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   ServicePhotos(serviceDataId: serviceModel.service.id)));
//     }
//   }
// }
