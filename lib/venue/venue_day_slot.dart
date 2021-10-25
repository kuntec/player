import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/dayslot_data.dart';
import 'package:player/venue/add_venue_photos.dart';
import 'package:player/venue/venue_time_slot.dart';

class VenueDaySlot extends StatefulWidget {
  dynamic venue;
  VenueDaySlot({this.venue});

  @override
  _VenueDaySlotState createState() => _VenueDaySlotState();
}

class _VenueDaySlotState extends State<VenueDaySlot> {
  List<DaySlot>? dayslots;
  TimeOfDay? openTime;
  TimeOfDay? closeTime;

  // var txtOpenTime = "Select Start Date";
  // var txtEndDate = "Select End Date";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDaySlots();
  }

  Future pickTime(BuildContext context, int index, bool isOpen) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: openTime ?? initialTime,
    );

    if (newTime == null) return;
    setState(() {
      openTime = newTime;
      if (openTime == null) {
        //txtTime = "Select Time";
      } else {
        int hour = openTime!.hour;
        int minute = openTime!.minute;
        String h = hour.toString();
        String m = minute.toString();
        if (hour < 10) {
          h = "0" + h;
        }
        if (minute < 10) {
          m = "0" + m;
        }

        if (isOpen) {
          dayslots![index].open = "$h:$m";
        } else {
          dayslots![index].close = "$h:$m";
        }
        setState(() {});
        //txtTime = "${openTime!.hour}:${openTime!.minute}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Venue")),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedButton(
                title: "Upload Photos",
                color: kBaseColor,
                txtColor: Colors.white,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddVenuePhotos(
                                venue: widget.venue,
                              )));
                },
              ),
              SizedBox(height: 10.0),
              Text(
                "Choose day when turf is close",
              ),
              SizedBox(height: 10.0),
              dayslots != null ? dayBar() : SizedBox(height: 10.0),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  "Slot Timing",
                  style: TextStyle(color: kBaseColor, fontSize: 18.0),
                ),
              ),
              SizedBox(height: 10.0),
              dayslots != null
                  ? Container(
                      child: Column(
                        children: [
                          dayslots![0].status == "1"
                              ? slotTime(dayslots![0])
                              : SizedBox(height: 1.0),
                          dayslots![1].status == "1"
                              ? slotTime(dayslots![1])
                              : SizedBox(height: 1.0),
                          dayslots![2].status == "1"
                              ? slotTime(dayslots![2])
                              : SizedBox(height: 1.0),
                          dayslots![3].status == "1"
                              ? slotTime(dayslots![3])
                              : SizedBox(height: 1.0),
                          dayslots![4].status == "1"
                              ? slotTime(dayslots![4])
                              : SizedBox(height: 1.0),
                          dayslots![5].status == "1"
                              ? slotTime(dayslots![5])
                              : SizedBox(height: 1.0),
                          dayslots![6].status == "1"
                              ? slotTime(dayslots![6])
                              : SizedBox(height: 1.0),
                        ],
                      ),
                    )
                  : SizedBox(height: 10.0),
              SizedBox(height: 10.0),
              RoundedButton(
                title: "Next",
                color: kBaseColor,
                txtColor: Colors.white,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  _onLoading();
                  // goToTimeSlot();
                  // if (isAvailable!) {
                  //   print("UPDATE");
                  //   print("DAY SLOT FOUND $isAvailable");
                  // } else {
                  //   print("ADD");
                  //   print("DAY SLOT NOT  $isAvailable");
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    isAvailable! ? updateDaySlots() : addDaySlots();
    // new Future.delayed(new Duration(seconds: 3), () {
    //   Navigator.pop(context); //pop dialog
    // });
  }

  addDaySlots() async {
    print("ADD Day Slot");
    //Navigator.pop(context);
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    DayslotData? dayslotData;
    if (connectivityStatus) {
      for (int i = 0; i < dayslots!.length; i++) {
        dayslotData = await apiCall.addDaySlot(
          dayslots![i],
        );
      }

      if (dayslotData != null) {
        if (dayslotData.status!) {
          addDayTimeSlot();
          Utility.showToast("Successfully Added");
        } else {
          Utility.showToast("Failed");
        }
      }
    }
  }

  updateDaySlots() async {
    print("Update Day Slot");
    // Navigator.pop(context);
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    DayslotData? dayslotData;
    if (connectivityStatus) {
      for (int i = 0; i < dayslots!.length; i++) {
        dayslotData = await apiCall.updateDaySlot(
          dayslots![i],
        );
      }

      Navigator.pop(context);
      if (dayslotData != null) {
        if (dayslotData.status!) {
          goToTimeSlot();
          Utility.showToast("Successfully Updated");
        } else {
          Utility.showToast("Failed");
        }
      }
    }
  }

  addDayTimeSlot() async {
    print("Adding day time slot");
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    DayslotData? dayslotData;
    if (connectivityStatus) {
      dayslotData = await apiCall.addDayTimeSlot(widget.venue.id.toString());

      Navigator.pop(context);
      if (dayslotData.status!) {
        isAvailable = true;
        goToTimeSlot();
        Utility.showToast("Success");
//        Navigator.pop(context);
      } else {
        Utility.showToast("Failed");
      }
    }
  }

  goToTimeSlot() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => VenueTimeSlot(
                  venue: widget.venue,
                  dayslots: dayslots,
                )));
  }

  bool? isAvailable;
  getDaySlots() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    DayslotData? dayslotData;
    if (connectivityStatus) {
      dayslotData = await apiCall.getDaySlot(widget.venue.id.toString());
      if (dayslotData.daySlots != null) {
        if (dayslotData.status!) {
          dayslots = dayslotData.daySlots!;
          isAvailable = true;
          print("DAY SLOT FOUND $isAvailable");
          Utility.showToast("Success");
          setState(() {});
        } else {
          Utility.showToast("Failed");
        }
      } else {
        isAvailable = false;
        dayslots = [];
        for (int i = 0; i < 7; i++) {
          DaySlot d = new DaySlot();
          d.venueId = widget.venue.id.toString();
          d.day = i.toString();
          d.status = "1";
          d.open = "00:00";
          d.close = "00:00";
          d.createdAt = Utility.getCurrentDate();
          dayslots!.add(d);
        }

        Utility.showToast("initialize days");
      }
      setState(() {});
    }
  }

  dayBar() {
    return Container(
      height: 40,
      padding: EdgeInsets.all(3.0),
      decoration: kBoxDecor,
      child: Row(
        children: [
          dayItem("Sun", 0),
          dayItem("Mon", 1),
          dayItem("Tue", 2),
          dayItem("Wed", 3),
          dayItem("Thu", 4),
          dayItem("Fri", 5),
          dayItem("Sat", 6),
        ],
      ),
    );
  }

  // List selectedDays = [1, 2, 3, 4, 5, 6, 7];

  dayItem(String name, int id) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          for (int i = 0; i < dayslots!.length; i++) {
            if (dayslots![i].day == id.toString()) {
              //print("Found double");
              if (dayslots![i].status == "0") {
                // print("status change to 0");
                dayslots![i].status = "1";
              } else {
                //print("status change to 1");
                dayslots![i].status = "0";
              }
            } else {}
          }
          //selectedDays.add(id);
          setState(() {});
        },
        child: Container(
          color: dayslots![id].status == "1" ? Colors.white : Colors.red,
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                  color:
                      dayslots![id].status == "1" ? Colors.black : Colors.white,
                  fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }

  slotTime(dynamic day) {
    int index = int.parse(day.day);
    return Container(
      height: 50,
      padding: EdgeInsets.all(5.0),
      //decoration: kBoxDecor,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "MON ${day.day}",
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                pickTime(context, index, true);
              },
              child: Container(
                padding: EdgeInsets.all(5.0),
                height: 30,
                //width: 80,
                decoration: kBoxDecor,
                child: Center(
                  child: Text(day.open),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "",
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "To",
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                pickTime(context, index, false);
              },
              child: Container(
                padding: EdgeInsets.all(5.0),
                height: 30,
                // width: 80,
                decoration: kBoxDecor,
                child: Center(
                  child: Text(day.close),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
