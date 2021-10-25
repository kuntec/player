import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/timeslot_data.dart';
import 'package:player/venue/add_venue_photos.dart';

class AddVenueSlot extends StatefulWidget {
  dynamic venue;
  AddVenueSlot({this.venue});

  @override
  _AddVenueSlotState createState() => _AddVenueSlotState();
}

class _AddVenueSlotState extends State<AddVenueSlot> {
  TimeOfDay? openTime;
  TimeOfDay? closeTime;

  Timeslot? timeslot;

  var txtOpenTime = "Open Time";
  var txtCloseTime = "Close Time";
  var noSlot;
  var price;

  TextEditingController slotController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Venue Slots")),
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
            children: [
              addVenueForm(),
              SizedBox(height: k20Margin),
              myTimeslots(),
              SizedBox(height: k20Margin),
              RoundedButton(
                title: "Upload Photos",
                color: kBaseColor,
                txtColor: Colors.white,
                minWidth: 250,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddVenuePhotos(
                                venue: widget.venue,
                              )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickTime(BuildContext context, bool isOpen) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return;

    if (newTime == null) return;
    setState(() {
      openTime = newTime;
      if (openTime != null) {
        if (isOpen) {
          if (openTime!.hour < 10) {
            var hour = "0" + openTime!.hour.toString();
            if (openTime!.minute < 10) {
              var minute = "0" + openTime!.minute.toString();
              txtOpenTime = "$hour:$minute";
            }
          }
          txtOpenTime = "${openTime!.hour}:${openTime!.minute}";
        } else {
          txtCloseTime = "${openTime!.hour}:${openTime!.minute}";
        }
      }
    });
  }

  var selectedDay;
  Widget addVenueForm() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: selectedDay,
            hint: Text("Select Day"),
            items: <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              selectedDay = newValue;
              setState(() {});
            },
          ),
          SizedBox(height: k20Margin),
          Container(
              child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    pickTime(context, true);
                  },
                  child: Text(
                    txtOpenTime,
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    pickTime(context, false);
                  },
                  child: Text(
                    txtCloseTime,
                  ),
                ),
              ),
            ],
          )),
          SizedBox(height: k20Margin),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: slotController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      noSlot = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Slot Max Person",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
                SizedBox(width: k20Margin),
                Expanded(
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      price = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Price",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: k20Margin),
          RoundedButton(
            title: "Add",
            color: kBaseColor,
            txtColor: Colors.white,
            minWidth: 250,
            onPressed: () async {
              timeslot = new Timeslot();
              timeslot!.day = selectedDay;
              timeslot!.startTime = txtOpenTime;
              timeslot!.endTime = txtCloseTime;
              timeslot!.venueId = widget.venue.id.toString();
              timeslot!.noSlot = noSlot.toString();
              timeslot!.price = price.toString();

              addTimeslot();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => AddVenuePhotos()));
            },
          ),
        ],
      ),
    );
  }

  addTimeslot() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      TimeslotData timeslotData = await apiCall.addTimeslot(timeslot!);

      if (timeslotData == null) {
        print("Timeslot null");
      } else {
        if (timeslotData.status!) {
          print("Timeslot Success");
          Utility.showToast("Timeslot Created Successfully");
          slotController.text = "";
          priceController.text = "";
          txtOpenTime = "Open Time";
          txtCloseTime = "Close Time";
          setState(() {});
//          Navigator.pop(context);
        } else {
          print("Timeslot Failed");
        }
      }
    }
  }

  Widget myTimeslots() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(20.0),
      child: FutureBuilder(
        future: getTimeslots(),
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
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('No Timeslots'),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 110),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return timeslotItem(snapshot.data[index]);
                },
              );
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

  List<Timeslot>? timeslots;

  Future<List<Timeslot>?> getTimeslots() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      TimeslotData timeslotData =
          await apiCall.getTimeslot(widget.venue.id.toString());

      if (timeslotData == null) {
        print("Timeslot null");
      } else {
        if (timeslotData.status!) {
          print("Timeslot Success");
          //Utility.showToast("Timeslot Get Successfully");
          // timeslots!.clear();
          timeslots = timeslotData.timeslots;
//          Navigator.pop(context);
        } else {
          print("Timeslot Failed");
        }
      }
    }
    return timeslots;
  }

  timeslotItem(dynamic timeslot) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(timeslot.day)),
          Expanded(flex: 1, child: Text(timeslot.startTime)),
          Expanded(flex: 1, child: Text(timeslot.endTime)),
          Expanded(flex: 1, child: Text(timeslot.noSlot)),
          Expanded(flex: 1, child: Text(timeslot.price)),
          GestureDetector(
            onTap: () async {
              Utility.showToast("Deleted ${timeslot.id} ${timeslot.day}");
              await deleteTimeslot(timeslot.id.toString());
            },
            child: Expanded(
              flex: 1,
              child: Icon(
                Icons.delete_forever,
                color: kBaseColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<TimeslotData?> deleteTimeslot(String id) async {
    APICall apiCall = new APICall();
    TimeslotData? timeslotData;
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      timeslotData = await apiCall.deleteTimeslot(id);

      if (timeslotData == null) {
        print("Timeslot null");
      } else {
        if (timeslotData.status!) {
          print("Timeslot Success");
          Utility.showToast("Timeslot Deleted Successfully");
          setState(() {});
//          Navigator.pop(context);
        } else {
          print("Timeslot Failed");
        }
      }
    }
    return timeslotData;
  }
}
