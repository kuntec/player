import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';

class AddTournament extends StatefulWidget {
  const AddTournament({Key? key}) : super(key: key);

  @override
  _AddTournamentState createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  bool? isMyTournamentSelected = false;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? time;

  var txtStartDate = "Select Start Date";
  var txtEndDate = "Select End Date";
  var txtTime = "Select Time";

  TextEditingController? txtstartDateController;
  TextEditingController? txtEndDateController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Host Tournament")),
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
        child: Column(
          children: [
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
                          isMyTournamentSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabLeftDecoration.copyWith(
                            color: isMyTournamentSelected!
                                ? Colors.white
                                : kBaseColor),
                        child: Center(
                          child: Text(
                            "New Tournament",
                            style: TextStyle(
                                color: isMyTournamentSelected!
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
                          isMyTournamentSelected = true;
                        });
                        //getMyHostActivity();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: kContainerTabRightDecoration.copyWith(
                            color: isMyTournamentSelected!
                                ? kBaseColor
                                : Colors.white),
                        child: Center(
                          child: Text(
                            "My Tournament",
                            style: TextStyle(
                                color: isMyTournamentSelected!
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
            isMyTournamentSelected! ? myTournament() : addTournamentForm()
          ],
        ),
      ),
    );
  }

  Widget myTournament() {
    return Container(
      child: Column(
        children: [
          Text("My Tournament"),
        ],
      ),
    );
  }

  Widget addTournamentForm() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 150,
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl:
                    "https://www.lifewire.com/thmb/P856-0hi4lmA2xinYWyaEpRIckw=/1920x1326/filters:no_upscale():max_bytes(150000):strip_icc()/cloud-upload-a30f385a928e44e199a62210d578375a.jpg",
                placeholder: (context, url) => Image(
                  image: AssetImage('assets/images/no_user.jpg'),
                ),
              ),
              // child: Image(
              //   image: AssetImage(
              //     'assets/images/banner.jpg',
              //   ),
              //   width: MediaQuery.of(context).size.width,
              // ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("Camera Clicked");
            },
            child: Container(
              child: Icon(
                Icons.camera_alt_outlined,
                size: 30,
                color: kBaseColor,
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Organizer Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Organizer Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Tournament Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          SizedBox(
            height: k20Margin,
          ),
          Container(
              child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    pickDate(context, true);
                  },
                  child: Text(
                    txtStartDate,
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
                    pickDate(context, false);
                  },
                  child: Text(
                    txtEndDate,
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: TextField(
              //     onTap: () {
              //       pickDate(context);
              //     },
              //     controller: txtEndDateController,
              //     // enabled: false,
              //     decoration: InputDecoration(
              //         prefixIcon: Icon(Icons.calendar_today_outlined),
              //         labelText: "End Date",
              //         labelStyle: TextStyle(
              //           color: Colors.grey,
              //         )),
              //   ),
              // ),
            ],
          )),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Entry Fees",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      pickTime(context);
                    },
                    child: Text(
                      txtTime,
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: TextField(
                //     decoration: InputDecoration(
                //         labelText: "Timing (From to To)",
                //         labelStyle: TextStyle(
                //           color: Colors.grey,
                //         )),
                //   ),
                // ),
              ],
            ),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Number of team members",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Any Age Requirement",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Tournament Location (Address)",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Prize Details",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Any Other Information",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          SizedBox(height: k20Margin),
          RoundedButton(
            title: "Create Tournament",
            color: kBaseColor,
            txtColor: Colors.white,
            minWidth: 250,
            onPressed: () async {},
          ),
        ],
      ),
    );
  }

  Future pickDate(BuildContext context, bool isStart) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;
    setState(() {
      startDate = newDate;
      if (startDate == null) {
      } else {
        if (isStart) {
          txtStartDate =
              "${startDate!.day}-${startDate!.month}-${startDate!.year}";
        } else {
          txtEndDate =
              "${startDate!.day}-${startDate!.month}-${startDate!.year}";
        }

        setState(() {});
        //     txtDate = "${date!.day}-${date!.month}-${date!.year}";
      }
    });
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    if (newTime == null) return;
    setState(() {
      time = newTime;
      if (time == null) {
        txtTime = "Select Time";
      } else {
        txtTime = "${time!.hour}:${time!.minute}";
      }
    });
  }
}
