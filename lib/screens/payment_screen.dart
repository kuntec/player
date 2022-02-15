import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/api/api_resources.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/participant_data.dart';
import 'package:player/screens/booking_confirmation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {
  dynamic participant;
  dynamic event;
  PaymentScreen({this.participant, this.event});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Participant? participant;

  bool? isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Text(
            "Booking",
            style: TextStyle(color: Colors.black),
          ),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBaseColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(kMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   widget.participant.type == "1" ? "Event" : "Tournament",
              //   style: TextStyle(color: Colors.black87, fontSize: 18.0),
              // ),
              widget.participant.type == "1"
                  ? eventItem(widget.event)
                  : tournamentItem(widget.event),
              participantItem(widget.participant),
              SizedBox(height: kMargin),
              Container(
                margin: EdgeInsets.only(left: k20Margin, right: k20Margin),
                child: isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(color: kBaseColor))
                    : RoundedButton(
                        title: widget.participant.paymentMode == "1"
                            ? "Proceed"
                            : "Confirm Booking",
                        color: kBaseColor,
                        txtColor: Colors.white,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          widget.participant.paymentStatus = "0";
                          addParticipant(widget.participant);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addParticipant(Participant participant) async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    print("Participant add");
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      ParticipantData participantData =
          await apiCall.addParticipant(participant);
      setState(() {
        isLoading = false;
      });
      if (participantData == null) {
        print("Participant null");
      } else {
        if (participantData.status!) {
          print("Participant Success");
          Utility.showToast("Participant Added Successfully");
          var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingConfirmation(status: true)));
          if (result == true) {
            Navigator.pop(context, true);
          }
        } else {
          print("Participant Failed");
        }
      }
    } else {
      print("No Connectivity");
    }
  }

  participantItem(dynamic participant) {
    return Container(
      margin: EdgeInsets.all(5.0),
      width: MediaQuery.of(context).size.width,
      decoration: kBoxDecor,
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Name: ${participant.name}",
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(height: kMargin),
            Container(
              child: Text(
                "Number: ${participant.number}",
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(height: kMargin),
            Container(
              child: Text(
                "Gender: ${participant.gender}",
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(height: kMargin),
            Container(
              child: Text(
                "Age: ${participant.age}",
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(height: kMargin),
            Container(
              child: Text(
                "Amount: \u{20B9} ${participant.amount}",
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(height: kMargin),
            Container(
              child: Text(
                participant.paymentMode == "0"
                    ? "Payment Mode : Offline"
                    : "Payment Mode : Online",
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(height: kMargin),
          ],
        ),
      ),
    );
  }

  Widget eventItem(dynamic event) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(5.0),
//      padding: EdgeInsets.only(bottom: 10.0),
        decoration: kBoxDecor,
        // height: 200,
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    height: 80.0,
                    width: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        APIResources.IMAGE_URL + event.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Row(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 100.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text(
                    event.name,
                    style: TextStyle(
                        color: kBaseColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    event.address,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Start Date: ${event.startDate}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Location: ${event.address}",
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

  Widget tournamentItem(dynamic tournament) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10.0),
//      padding: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        // height: 200,
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    height: 85.0,
                    width: 85.0,
                    // child: SvgPicture.network(
                    //   "https://www.svgrepo.com/show/2046/dog.svg",
                    //   placeholderBuilder: (context) =>
                    //       CircularProgressIndicator(),
                    //   height: 110.0,
                    //   width: 110,
                    //   fit: BoxFit.cover,
                    // ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        APIResources.IMAGE_URL + tournament.image,
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
                  SizedBox(height: 5.0),
                  Text(
                    tournament.tournamentName,
                    style: TextStyle(
                        color: kBaseColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Start Date: ${tournament.startDate}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Location: ${tournament.address}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "Location: ${tournament.sportName}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "\u{20B9} ${tournament.entryFees}",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                  // Text(
                  //   "Time: ${tournament.startTime} to ${tournament.startTime}",
                  //   style: TextStyle(
                  //     color: Colors.grey.shade900,
                  //     fontSize: 14.0,
                  //   ),
                  // ),
                  // SizedBox(height: 5.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
