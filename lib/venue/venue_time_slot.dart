import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/constant/utility.dart';

class VenueTimeSlot extends StatefulWidget {
  dynamic venue;
  dynamic dayslots;
  VenueTimeSlot({this.venue, this.dayslots});

  @override
  _VenueTimeSlotState createState() => _VenueTimeSlotState();
}

class _VenueTimeSlotState extends State<VenueTimeSlot> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venue TimeSlot"),
      ),
    );
  }

  calculateSlots() {}

  getTimeSlots() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();

    if (connectivityStatus) {
      await apiCall.getTimeslot(widget.venue.id.toString());
    }
//      HostActivity hostActivity = await apiCall.addHostActivity(activity!);
    // Navigator.pop(context);
//       if (dayslotData != null) {
//         if (dayslotData.status!) {
//           goToTimeSlot();
//           Utility.showToast("Success");
// //        Navigator.pop(context);
//         } else {
//           Utility.showToast("Failed");
//         }
//       }
  }
}
