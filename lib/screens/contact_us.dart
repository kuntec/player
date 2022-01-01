import 'package:flutter/material.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            onSuccess(),
          ],
        ),
      ),
    ));
  }

  Widget onSuccess() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: kBaseColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          )
        ],
      ),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text(
            "Mail Us",
            style: TextStyle(fontSize: 24.0, color: kBaseColor),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'playerindia.in@gmail.com',
                query: encodeQueryParameters(<String, String>{}),
              );

              launch(emailLaunchUri.toString());
              Utility.showToast("Mail");
            },
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 35,
              child: Icon(
                Icons.mail_outline,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "playerindia.in@gmail.com",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Call Us",
            style: TextStyle(fontSize: 24.0, color: kBaseColor),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Utility.launchCall("+917698199502");
            },
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 35,
              child: Icon(
                Icons.phone,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "+91 7698199502",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ),
          ),

          SizedBox(height: 30),
          Text(
            "Whatsapp Us",
            style: TextStyle(fontSize: 24.0, color: kBaseColor),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              launchWhatsapp(number: "+917698199502", message: "");
            },
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 35,
              child: Icon(
                Icons.chat_bubble,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "+91 7698199502",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ),
          ),
          // Text(
          //   "Thanks For Booking",
          //   style: TextStyle(fontSize: 14.0, color: Colors.black54),
          // ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void launchWhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(url) ? launch(url) : print("Can't Open Whatsapp");
  }
}
