import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/booking_data.dart';
import 'package:player/model/timeslot_data.dart';
import 'package:player/screens/booking_confirmation.dart';

class BookingSummary extends StatefulWidget {
  dynamic booking;
  dynamic venue;
  dynamic bookedTimeSlots;

  BookingSummary({this.booking, this.venue, this.bookedTimeSlots});

  @override
  _BookingSummaryState createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  double? total = 0.0;
  List<Timeslot>? timeslots;
  Booking? _booking;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeslots = widget.bookedTimeSlots;
    _booking = widget.booking;
    calculateTotal();
  }

  calculateTotal() {
    total = 0.0;
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Booking Summary",
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          //  Utility.showToast("TAP");
          addBooking();
        },
        child: isLoading == true
            ? Container(
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    color: kBaseColor,
                  ),
                ),
              )
            : Container(
                color: kBaseColor,
                height: 50,
                child: Center(
                    child: Text(
                  "Total Amount $total  Confirm Booking",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                )),
              ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            timeslots != null ? buildTimeSlot2() : Container(),
          ],
        ),
      ),
    );
  }

  buildTimeSlot2() {
    return timeslots!.length == 0
        ? Container(
            margin: EdgeInsets.all(20.0),
            child: Text("No TimeSlot Found on this Day"),
          )
        : Container(
            margin: EdgeInsets.only(top: 10.0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: timeslots!.length,
                itemBuilder: (context, index) {
                  return slotItem(timeslots![index], index);
                }),
            // child: GridView.builder(
            //     itemCount: widget.bookedTimeSlots!.length,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3),
            //     itemBuilder: (context, index) {
            //       return slotItem(widget.bookedTimeSlots![index], index);
            //     }),
          );
  }

  slotItem(dynamic data, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 50,
        decoration: kServiceBoxItem,
//        decoration: kContainerBox.copyWith(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 10.0),
              child: Text(
                "${data.bookedDay}",
                style: TextStyle(color: kBaseColor, fontSize: 18.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 5.0),
              child: Text(
                "${data.startTime}",
                style: TextStyle(color: kBaseColor, fontSize: 18.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 5.0),
              child: Text(
                "\u{20B9} ${data.price}",
                style: TextStyle(color: kBaseColor, fontSize: 18.0),
              ),
            ),
            GestureDetector(
              onTap: () {
                timeslots!.removeAt(index);
                calculateTotal();
                Utility.showToast("Remove ${data.price}");
              },
              child: Container(
                margin: EdgeInsets.only(right: 5, bottom: 5.0),
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool? isLoading = false;
  var bookingId;

  addBooking() async {
    setState(() {
      isLoading = true;
    });
    APICall apiCall = new APICall();
    print("Booking add");
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      BookingData bookingData = await apiCall.addBooking(_booking!);

      if (bookingData == null) {
        print("bookingData null");
      } else {
        if (bookingData.status!) {
          bookingId = bookingData.booking!.id.toString();
          print("bookingData Success");
          // Utility.showToast("Booking Added Successfully");
          // Add Timeslots
          addBookedTimeslot(bookingId);
          //Navigator.pop(context, true);
        } else {
          print("Booking Failed");
        }
      }
    } else {
      print("No Connectivity");
    }
  }

  addBookedTimeslot(var bookingId) async {
    APICall apiCall = new APICall();
    print("Slots add");
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      BookingData bookingData = new BookingData();

      for (Timeslot t in timeslots!) {
        Slot s = new Slot();
        s.venueId = t.venueId;
        s.timeSlotId = t.id.toString();
        s.bookingDate = t.bookedDay;
        s.day = t.day;
        s.price = t.price;
        s.startTime = t.startTime.toString();
        s.bookingId = bookingId.toString();
        bookingData = await apiCall.addBookingSlot(s);
      }

      setState(() {
        isLoading = false;
      });
      if (bookingData == null) {
        print("Slots null");
      } else {
        if (bookingData.status!) {
          print("Slots Success");
          Utility.showToast("Booking Added Successfully");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingConfirmation(status: true)));
          // Navigator.pop(context, true);
        } else {
          print("Slots Failed");
        }
      }
    } else {
      print("No Connectivity");
    }
  }
}
