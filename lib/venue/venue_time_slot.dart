import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/dayslot_data.dart';
import 'package:player/model/timeslot_data.dart';

class VenueTimeSlot extends StatefulWidget {
  dynamic venue;
//  dynamic dayslots;
  VenueTimeSlot({this.venue});

  @override
  _VenueTimeSlotState createState() => _VenueTimeSlotState();
}

class _VenueTimeSlotState extends State<VenueTimeSlot> {
  List<Timeslot>? timeslots;
  List<DaySlot>? dayslots;

  List<Timeslot>? selectedTimeslots = [];
  var selectedDay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDaySlots();
  }

  getDaySlots() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    DayslotData? dayslotData;
    if (connectivityStatus) {
      dayslotData = await apiCall.getDaySlot(widget.venue.id.toString());
      if (dayslotData.daySlots != null) {
        if (dayslotData.status!) {
          dayslots = dayslotData.daySlots!;
          for (var d in dayslots!) {
            // print("Day ${d.day} - ${d.status}");
            if (d.status == "1") {
              int day = int.parse(d.day.toString());
              selectedDay = day;
              break;
            }
          }
          //setState(() {});
          getTimeSlots();
        } else {
          Utility.showToast("Failed");
        }
      }
      //setState(() {});
    }
  }

  bool isFirstEntry = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venue TimeSlot"),
        actions: [
          GestureDetector(
            onTap: () {
              //Utility.showToast("SAVE");
              Navigator.pop(context);
              // for (var t in timeslots!) {
              //   t.price = "0";
              //   t.noSlot = "0";
              //   updateTimeSlots(t);
              // }
            },
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: Icon(
                Icons.check,
                size: 30.0,
                color: kBaseColor,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              dayslots != null ? dayBar() : SizedBox(height: 10.0),
              selectedTimeslots != null ? buildTimeSlot2() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  dayBar() {
    return Container(
      height: 40,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(3.0),
      decoration: kBoxDecor,
      child: Row(
        children: [
          dayslots!
                  .any((element) => element.day == "0" && element.status == "1")
              ? dayItem("Sun", 0)
              : Container(),
          dayslots!
                  .any((element) => element.day == "1" && element.status == "1")
              ? dayItem("Mon", 1)
              : Container(),
          dayslots!
                  .any((element) => element.day == "2" && element.status == "1")
              ? dayItem("Tue", 2)
              : Container(),
          dayslots!
                  .any((element) => element.day == "3" && element.status == "1")
              ? dayItem("Wed", 3)
              : Container(),
          dayslots!
                  .any((element) => element.day == "4" && element.status == "1")
              ? dayItem("Thu", 4)
              : Container(),
          dayslots!
                  .any((element) => element.day == "5" && element.status == "1")
              ? dayItem("Fri", 5)
              : Container(),
          dayslots!
                  .any((element) => element.day == "6" && element.status == "1")
              ? dayItem("Sat", 6)
              : Container(),
          // dayItem("Mon", 1),
          // dayItem("Tue", 2),
          // dayItem("Wed", 3),
          // dayItem("Thu", 4),
          // dayItem("Fri", 5),
          // dayItem("Sat", 6),
        ],
      ),
    );
  }

  dayItem(String name, int id) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          selectedDay = id;
          if (selectedTimeslots != null) {
            selectedTimeslots!.clear();
            for (var t in timeslots!) {
              int day = int.parse(t.day.toString());
              if (day == selectedDay) {
                selectedTimeslots!.add(t);
              }
            }
          }
          // Utility.showToast("Selected Time slot length ${selectedTimeslots!.length}");
          //  Utility.showToast("Selected Day $selectedDay");

          setState(() {});
        },
        child: Container(
          color: selectedDay == id ? kBaseColor : Colors.white,
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                  color: selectedDay == id ? Colors.white : Colors.black,
                  fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }

  buildTimeSlot2() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
          itemCount: selectedTimeslots!.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return slotItem(selectedTimeslots![index], index);
          }),
    );
  }

  updateTimeSlots(Timeslot timeslot, int isDayStop) async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    TimeslotData timeslotData;
    if (connectivityStatus) {
      timeslotData = await apiCall.updateDayTimeslot(timeslot, isDayStop);
      if (timeslotData.status!) {
        getTimeSlots();
      }
    }
  }

  // buildTimeSlot() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height,
  //     child: FutureBuilder<List<Timeslot>?>(
  //       future: getTimeSlots(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return GridView.builder(
  //               itemCount: snapshot.data!.length,
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 3),
  //               itemBuilder: (context, index) {
  //                 return slotItem(snapshot.data![index]);
  //               });
  //         } else if (snapshot.hasError) {
  //           return Text("Error");
  //         }
  //         return Text("Loading...");
  //       },
  //     ),
  //   );
  // }

  Future<List<Timeslot>?> getTimeSlots() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    TimeslotData timeslotData;
    if (connectivityStatus) {
      timeslotData = await apiCall.getDayTimeslot(widget.venue.id.toString());
      if (timeslotData.timeslots != null) {
        if (timeslotData.status!) {
          timeslots = timeslotData.timeslots!;
          setState(() {});
          for (var t in timeslots!) {
            int price = int.parse(t.price.toString());
            int noSlot = int.parse(t.noSlot.toString());
            if (price != 0 || noSlot != 0) {
              isFirstEntry = false;
            }
          }

          if (selectedTimeslots != null) {
            selectedTimeslots!.clear();
            for (var t in timeslots!) {
              int day = int.parse(t.day.toString());
              if (day == selectedDay) {
                selectedTimeslots!.add(t);
              }
            }
          } else {
            print("SELECTED Time Slot NULL");
          }

          print("Time Slot ${timeslots!.length}");
        }
      }
    }
    setState(() {});
    return timeslots;
  }

  slotItem(dynamic data, int index) {
    // if (data.day == '1') {
    //   return Container(
    //     margin: EdgeInsets.only(left: 10),
    //     child: Text(
    //       "${data.day}",
    //       style: TextStyle(color: kBaseColor, fontSize: 18.0),
    //     ),
    //   );
    // }
    return GestureDetector(
      onTap: () {
        _showMaterialDialog(data, index);
        //_showCupertinoDialog();
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 40,
        height: 40,
        decoration: kServiceBoxItem.copyWith(
          borderRadius: BorderRadius.circular(5.0),
          color: data.bookingStatus == '0' || data.status == '0'
              ? Colors.red
              : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   margin: EdgeInsets.only(left: 10),
            //   child: Text(
            //     "${data.day}",
            //     style: TextStyle(color: kBaseColor, fontSize: 18.0),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "${data.startTime}",
                style: TextStyle(
                    color: data.bookingStatus == '0' || data.status == '0'
                        ? Colors.white
                        : kBaseColor,
                    fontSize: 16.0),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "\u{20B9} ${data.price}",
                style: TextStyle(
                    color: data.bookingStatus == '0' || data.status == '0'
                        ? Colors.white
                        : Colors.black87,
                    fontSize: 16.0),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(right: 5),
              child: Text(
                "${data.remainingSlot} Left",
                style: TextStyle(
                    color: data.bookingStatus == '0' || data.status == '0'
                        ? Colors.white
                        : Colors.grey,
                    fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMaterialDialog(slot, index) async {
    bool isTextEnabled;
    bool isStopBooking;
    bool isStopBookingDay = false;
    if (slot.bookingStatus == "1") {
      isTextEnabled = false;
      isStopBooking = false;
    } else {
      isTextEnabled = true;
      isStopBooking = true;
    }
    TextEditingController priceController = new TextEditingController();
    TextEditingController slotController = new TextEditingController();
    priceController.text = slot.price;
    slotController.text = slot.noSlot;
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Edit Time Slot'),
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: priceController,
                            enabled: !isTextEnabled,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Price",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextField(
                            controller: slotController,
                            enabled: !isTextEnabled,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "No Slot",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                      ],
                    ),
                    !isFirstEntry
                        ? CheckboxListTile(
                            title: Text("Stop Booking"),
                            value: isTextEnabled,
                            onChanged: (value) {
                              setState(() {
                                isTextEnabled = value!;
                              });
                            })
                        : SizedBox(height: 1.0),
                    isTextEnabled
                        ? CheckboxListTile(
                            title: Text("Stop Booking This Slot "),
                            value: isStopBooking,
                            onChanged: (value) {
                              setState(() {
                                isStopBooking = value!;
                              });
                            })
                        : SizedBox(width: 10.0),
                    isTextEnabled
                        ? CheckboxListTile(
                            title: Text("Stop Booking For Entire Day "),
                            value: isStopBookingDay,
                            onChanged: (value) {
                              setState(() {
                                isStopBooking = value!;
                                isStopBookingDay = value;
                              });
                            })
                        : SizedBox(width: 10.0),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      _dismissDialog();
                    },
                    child: Text('Close')),
                TextButton(
                  onPressed: () {
                    // Utility.showToast(
                    //     "index = $index Price ${priceController.text}- Slot ${slotController.text} - id ${slot.id} - ${timeslots![index].price}");

                    for (var t in timeslots!) {
                      if (slot.id == t.id) {
                        print("Time slot ${t.price}");
                      }
                    }

                    if (isFirstEntry) {
                      for (var t in timeslots!) {
                        t.price = priceController.text;
                        t.noSlot = slotController.text;
                        t.remainingSlot = slotController.text;

                        updateTimeSlots(t, 0);
                      }
                      isFirstEntry = false;
                    } else {
                      for (var t in timeslots!) {
                        int id = int.parse(slot.id.toString());
                        if (id == t.id) {
                          t.noSlot = slotController.text;
                          t.price = priceController.text;
                          if (isStopBooking) {
                            t.bookingStatus = "0";
                          } else {
                            t.bookingStatus = "1";
                          }
                          if (isStopBookingDay) {
                            updateTimeSlots(t, 1);
                          } else {
                            updateTimeSlots(t, 0);
                          }
                          // updateTimeSlots(t);
                          print("Time slot ${t.price}");
                        }
                      }
                    }

                    _dismissDialog();
                  },
                  child: Text('Save'),
                )
              ],
            );
          });
        });
  }

  // void _showCupertinoDialog() async {
  //   return await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       int? selectedRadio = 0;
  //       return AlertDialog(
  //         content: StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: List<Widget>.generate(4, (int index) {
  //                 return Radio<int>(
  //                   value: index,
  //                   groupValue: selectedRadio,
  //                   onChanged: (int? value) {
  //                     setState(() => selectedRadio = value);
  //                   },
  //                 );
  //               }),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  _dismissDialog() {
    Navigator.pop(context);
  }
}
