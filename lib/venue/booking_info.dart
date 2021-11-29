import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/booking_data.dart';
import 'package:player/model/timeslot_data.dart';
import 'package:player/venue/booking_summary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingInfo extends StatefulWidget {
  dynamic venue;
  dynamic bookedTimeSlots;

  BookingInfo({this.venue, this.bookedTimeSlots});

  @override
  _BookingInfoState createState() => _BookingInfoState();
}

class _BookingInfoState extends State<BookingInfo> {
  double? total = 0.0;
  List<Timeslot>? timeslots;

  var name;
  var number;
  var gender;
  var age;
  var amount;
  var paymentMode;

  Booking? booking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeslots = widget.bookedTimeSlots;

    calculateTotal();
  }

  calculateTotal() {
    for (Timeslot t in timeslots!) {
      double amount = double.parse(t.price.toString());
      total = total! + amount;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Summary"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.bookedTimeSlots != null ? bookingForm() : Container(),
          ],
        ),
      ),
    );
  }

  Widget bookingForm() {
    return Container(
      margin: EdgeInsets.all(kMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fill your details",
            style: TextStyle(color: Colors.black87, fontSize: 18.0),
          ),
          SizedBox(height: kMargin),
          TextField(
            onChanged: (value) {
              name = value;
            },
            decoration: InputDecoration(
                labelText: "Enter Your Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          SizedBox(height: kMargin),
          TextField(
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              number = value;
            },
            decoration: InputDecoration(
                labelText: "Contact Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          SizedBox(height: kMargin),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              age = value;
            },
            decoration: InputDecoration(
                labelText: "Age",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          SizedBox(height: kMargin),
          Center(child: Text("Gender")),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 10,
                child: Radio(
                  value: "Male",
                  groupValue: gender,
                  onChanged: (value) {
                    gender = value.toString();
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                flex: 10,
                child: GestureDetector(
                    onTap: () {
                      gender = "Male";
                      setState(() {});
                    },
                    child: Text("Male")),
              ),
              Expanded(
                flex: 10,
                child: Radio(
                  value: "Female",
                  groupValue: gender,
                  onChanged: (value) {
                    gender = value.toString();
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                flex: 10,
                child: GestureDetector(
                  onTap: () {
                    gender = "Female";
                    setState(() {});
                  },
                  child: Text("Female"),
                ),
              ),
              Expanded(
                flex: 10,
                child: Radio(
                  value: "Other",
                  groupValue: gender,
                  onChanged: (value) {
                    gender = value.toString();
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                flex: 10,
                child: GestureDetector(
                  onTap: () {
                    gender = "Other";
                    setState(() {});
                  },
                  child: Text("Other"),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: kMargin),
          Center(child: Text("Payment Mode")),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 10,
                child: Radio(
                  value: "1",
                  groupValue: paymentMode,
                  onChanged: (value) {
                    // uncomment this line for online mode activation
                    // paymentMode = value.toString();
                    paymentMode = "0";
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                flex: 10,
                child: GestureDetector(
                    onTap: () {
                      // uncomment this line for online mode activation
                      // paymentMode = "0";
                      paymentMode = "0";
                      setState(() {});
                    },
                    child: Text("Online")),
              ),
              Expanded(
                flex: 10,
                child: Radio(
                  value: "0",
                  groupValue: paymentMode,
                  onChanged: (value) {
                    paymentMode = value.toString();
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                flex: 10,
                child: GestureDetector(
                  onTap: () {
                    paymentMode = "0";
                    setState(() {});
                  },
                  child: Text("Offline"),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: k20Margin),
          Container(
            margin: EdgeInsets.only(left: k20Margin, right: k20Margin),
            child: RoundedButton(
              title: "Proceed To Payment",
              color: kBaseColor,
              txtColor: Colors.white,
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var playerId = prefs.get("playerId");
                if (name == null || Utility.checkValidation(name)) {
                  Utility.showToast("Please enter name");
                  return;
                }
                if (number == null || Utility.checkValidation(number)) {
                  Utility.showToast("Please enter number");
                  return;
                }
                if (gender == null || Utility.checkValidation(gender)) {
                  Utility.showToast("Please select gender");
                  return;
                }
                if (age == null || Utility.checkValidation(age)) {
                  Utility.showToast("Please enter age");
                  return;
                }

                if (paymentMode == null ||
                    Utility.checkValidation(paymentMode)) {
                  Utility.showToast("Please select payment mode");
                  return;
                }

                // widget.isEvent == true ? type = "1" : type = "0";

                // amount = widget.event.entryFees;

                booking = new Booking();
                booking!.name = name.toString();
                booking!.playerId = playerId.toString();
                booking!.bookingStatus = "1";

                booking!.number = number.toString();
                booking!.age = age.toString();
                booking!.gender = gender.toString();
                booking!.paymentMode = paymentMode.toString();
                booking!.paymentStatus = "2";
                booking!.amount = total.toString();
                booking!.sportId = widget.venue.id.toString();
                booking!.venueId = widget.venue.id.toString();

                var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingSummary(
                              booking: booking,
                              venue: widget.venue,
                              bookedTimeSlots: widget.bookedTimeSlots,
                            )));
                if (result == true) {
                  Navigator.pop(context, true);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
