import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/dayslot_data.dart';
import 'package:player/model/timeslot_data.dart';
import 'package:player/venue/booking_info.dart';
import 'package:player/venue/booking_summary.dart';

class BookTimeSlot extends StatefulWidget {
  dynamic venue;
  //dynamic dayslots;
  BookTimeSlot({this.venue});

  @override
  _BookTimeSlotState createState() => _BookTimeSlotState();
}

class _BookTimeSlotState extends State<BookTimeSlot> {
  List<Timeslot>? timeslots;
  List<DaySlot>? dayslots;
  List<Timeslot>? bookedTimeslots = [];
  List<Timeslot>? selectedTimeslots = [];
  var selectedDay = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dayslots = widget.dayslots;
    // for (var d in dayslots!) {
    //   // print("Day ${d.day} - ${d.status}");
    //   if (d.status == "1") {
    //     int day = int.parse(d.day.toString());
    //     selectedDay = day;
    //     break;
    //   }
    // }
    final initialDate = DateTime.now();
    selectedDay = initialDate.day;
    startDate = initialDate;
    textStartDateController.text =
        "${startDate!.day}-${startDate!.month}-${startDate!.year}";
    getTimeSlots();
  }

  bool isFirstEntry = true;
  DateTime? startDate;
  TextEditingController textStartDateController = new TextEditingController();

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    print("initial Date = $initialDate");
    var lastDate = DateTime.now().add(Duration(days: 6));
    print("lastDate Date = $lastDate");
    final newDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? initialDate,
      firstDate: DateTime.now(),
      lastDate: lastDate,
    );

    if (newDate == null) return;
    setState(() {
      startDate = newDate;
      if (startDate == null) {
      } else {
        textStartDateController.text =
            "${startDate!.day}-${startDate!.month}-${startDate!.year}";
        selectedDay = startDate!.weekday;
        print("Selected Day $selectedDay");
        if (selectedDay == 7) {
          selectedDay = 0;
        }
        if (selectedTimeslots != null) {
          selectedTimeslots!.clear();
          for (var t in timeslots!) {
            int day = int.parse(t.day.toString());
            if (t.bookingStatus == "1") {
              if (day == selectedDay) {
                selectedTimeslots!.add(t);
              }
            }
          }
        }
        setState(() {});

        print("Date selected day ${startDate!.weekday}");
        //txtDate = "${date!.day}-${date!.month}-${date!.year}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Venue TimeSlot",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              if (bookedTimeslots!.length == 0) {
                Utility.showToast(
                    "Please Select At least one timeslot for booking");
                return;
              }
              var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookingInfo(
                            venue: widget.venue,
                            bookedTimeSlots: bookedTimeslots,
                          )));
              if (result == true) {
                Navigator.pop(context);
              }

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
              //dayslots != null ? dayBar() : SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                child: Center(
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      pickDate(context);
                    },
                    controller: textStartDateController,
                    decoration: InputDecoration(
                        labelText: "Select Date",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
              ),
              selectedTimeslots != null ? buildTimeSlot2() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  // dayBar() {
  //   return Container(
  //     height: 40,
  //     margin: EdgeInsets.all(10.0),
  //     padding: EdgeInsets.all(3.0),
  //     decoration: kBoxDecor,
  //     child: Row(
  //       children: [
  //         dayslots!
  //                 .any((element) => element.day == "0" && element.status == "1")
  //             ? dayItem("Sun", 0)
  //             : Container(),
  //         dayslots!
  //                 .any((element) => element.day == "1" && element.status == "1")
  //             ? dayItem("Mon", 1)
  //             : Container(),
  //         dayslots!
  //                 .any((element) => element.day == "2" && element.status == "1")
  //             ? dayItem("Tue", 2)
  //             : Container(),
  //         dayslots!
  //                 .any((element) => element.day == "3" && element.status == "1")
  //             ? dayItem("Wed", 3)
  //             : Container(),
  //         dayslots!
  //                 .any((element) => element.day == "4" && element.status == "1")
  //             ? dayItem("Thu", 4)
  //             : Container(),
  //         dayslots!
  //                 .any((element) => element.day == "5" && element.status == "1")
  //             ? dayItem("Fri", 5)
  //             : Container(),
  //         dayslots!
  //                 .any((element) => element.day == "6" && element.status == "1")
  //             ? dayItem("Sat", 6)
  //             : Container(),
  //         // dayItem("Mon", 1),
  //         // dayItem("Tue", 2),
  //         // dayItem("Wed", 3),
  //         // dayItem("Thu", 4),
  //         // dayItem("Fri", 5),
  //         // dayItem("Sat", 6),
  //       ],
  //     ),
  //   );
  // }

  // dayItem(String name, int id) {
  //   return Expanded(
  //     flex: 1,
  //     child: GestureDetector(
  //       onTap: () {
  //         selectedDay = id;
  //         if (selectedTimeslots != null) {
  //           selectedTimeslots!.clear();
  //           for (var t in timeslots!) {
  //             int day = int.parse(t.day.toString());
  //             if (day == selectedDay) {
  //               selectedTimeslots!.add(t);
  //             }
  //           }
  //         }
  //         // Utility.showToast("Selected Time slot length ${selectedTimeslots!.length}");
  //         //  Utility.showToast("Selected Day $selectedDay");
  //
  //         setState(() {});
  //       },
  //       child: Container(
  //         color: selectedDay == id ? kBaseColor : Colors.white,
  //         padding: EdgeInsets.all(5.0),
  //         child: Center(
  //           child: Text(
  //             name,
  //             style: TextStyle(
  //                 color: selectedDay == id ? Colors.white : Colors.black,
  //                 fontSize: 16.0),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  buildTimeSlot2() {
    return selectedTimeslots!.length == 0
        ? Container(
            margin: EdgeInsets.all(20.0),
            child: Text("No TimeSlot Found on this Day"),
          )
        : Container(
            margin: EdgeInsets.only(top: 10.0),
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                itemCount: selectedTimeslots!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return slotItem(selectedTimeslots![index], index);
                }),
          );
  }

  // updateTimeSlots(Timeslot timeslot) async {
  //   APICall apiCall = new APICall();
  //   bool connectivityStatus = await Utility.checkConnectivity();
  //   TimeslotData timeslotData;
  //   if (connectivityStatus) {
  //     timeslotData = await apiCall.updateDayTimeslot(timeslot);
  //   }
  // }

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
    return timeslots;
  }

  Timeslot? selectedSlot;

  slotItem(dynamic data, int index) {
    // if (data.day == 1) {
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
        if (data.remainingSlot == "0") {
          Utility.showToast("No Slot Left");
          return;
        }
        selectedSlot = data;
        for (int i = 0; i < bookedTimeslots!.length; i++) {
          if (bookedTimeslots![i] == selectedSlot) {
            print("Found double");
            bookedTimeslots!.remove(selectedSlot);
            setState(() {});
            return;
          } else {}
        }
        selectedSlot!.bookedDay = textStartDateController.text;
        bookedTimeslots!.add(selectedSlot!);
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        width: 50,
        height: 50,
        decoration: kServiceBoxItem.copyWith(
            borderRadius: BorderRadius.circular(5.0),
            color: bookedTimeslots!.any((element) =>
                    element.bookedDay == textStartDateController.text &&
                    element.id == data.id)
                ? kBaseColor
                : Colors.white),
//        decoration: kContainerBox.copyWith(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "${data.startTime}",
                style: TextStyle(
                    color: bookedTimeslots!.any((element) =>
                            element.bookedDay == textStartDateController.text &&
                            element.id == data.id)
                        ? Colors.white
                        : kBaseColor,
                    fontSize: 18.0),
              ),
            ),
            SizedBox(height: 5),
            Container(
              child: Text(
                "\u{20B9} ${data.price}",
                style: TextStyle(
                    color: bookedTimeslots!.any((element) =>
                            element.bookedDay == textStartDateController.text &&
                            element.id == data.id)
                        ? Colors.white
                        : Colors.black87,
                    fontSize: 18.0),
              ),
            ),
            SizedBox(height: 5),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(right: 5),
              child: Text(
                "${data.remainingSlot} Left",
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showMaterialDialog(slot, index) async {
  //   bool isTextEnabled;
  //   bool isStopBooking;
  //   if (slot.status == "1") {
  //     isTextEnabled = false;
  //     isStopBooking = false;
  //   } else {
  //     isTextEnabled = true;
  //     isStopBooking = true;
  //   }
  //   TextEditingController priceController = new TextEditingController();
  //   TextEditingController slotController = new TextEditingController();
  //   priceController.text = slot.price;
  //   slotController.text = slot.noSlot;
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(
  //             builder: (BuildContext context, StateSetter setState) {
  //           return AlertDialog(
  //             title: Text('Edit Time Slot'),
  //             content: Form(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: TextField(
  //                           controller: priceController,
  //                           enabled: !isTextEnabled,
  //                           keyboardType: TextInputType.number,
  //                           decoration: InputDecoration(
  //                               labelText: "Price",
  //                               labelStyle: TextStyle(
  //                                 color: Colors.grey,
  //                               )),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 10.0,
  //                       ),
  //                       Expanded(
  //                         child: TextField(
  //                           controller: slotController,
  //                           enabled: !isTextEnabled,
  //                           keyboardType: TextInputType.number,
  //                           decoration: InputDecoration(
  //                               labelText: "No Slot",
  //                               labelStyle: TextStyle(
  //                                 color: Colors.grey,
  //                               )),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   !isFirstEntry
  //                       ? CheckboxListTile(
  //                           title: Text("Stop Booking"),
  //                           value: isTextEnabled,
  //                           onChanged: (value) {
  //                             setState(() {
  //                               isTextEnabled = value!;
  //                             });
  //                           })
  //                       : SizedBox(height: 1.0),
  //                   isTextEnabled
  //                       ? CheckboxListTile(
  //                           title: Text("Stop Booking For Entire Day "),
  //                           value: isStopBooking,
  //                           onChanged: (value) {
  //                             setState(() {
  //                               isStopBooking = value!;
  //                             });
  //                           })
  //                       : SizedBox(width: 10.0),
  //                 ],
  //               ),
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                   onPressed: () {
  //                     _dismissDialog();
  //                   },
  //                   child: Text('Close')),
  //               TextButton(
  //                 onPressed: () {
  //                   Utility.showToast(
  //                       "index = $index Price ${priceController.text}- Slot ${slotController.text} - id ${slot.id} - ${timeslots![index].price}");
  //
  //                   for (var t in timeslots!) {
  //                     if (slot.id == t.id) {
  //                       print("Time slot ${t.price}");
  //                     }
  //                   }
  //
  //                   if (isFirstEntry) {
  //                     for (var t in timeslots!) {
  //                       t.price = priceController.text;
  //                       t.noSlot = slotController.text;
  //                       t.remainingSlot = slotController.text;
  //                       updateTimeSlots(t);
  //                     }
  //                     isFirstEntry = false;
  //                   } else {
  //                     for (var t in timeslots!) {
  //                       int id = int.parse(slot.id.toString());
  //                       if (id == t.id) {
  //                         t.noSlot = slotController.text;
  //                         t.price = priceController.text;
  //                         updateTimeSlots(t);
  //                         print("Time slot ${t.price}");
  //                       }
  //                     }
  //                   }
  //
  //                   _dismissDialog();
  //                 },
  //                 child: Text('Save'),
  //               )
  //             ],
  //           );
  //         });
  //       });
  // }
  //
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
  //
  // _dismissDialog() {
  //   Navigator.pop(context);
  // }
}
