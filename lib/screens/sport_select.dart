import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/screens/home.dart';
import 'package:player/screens/main_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SportSelect extends StatefulWidget {
  const SportSelect({Key? key}) : super(key: key);

  @override
  _SportSelectState createState() => _SportSelectState();
}

class _SportSelectState extends State<SportSelect> {
  bool? checked = false;
  int? playerId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // playerId = prefs.getInt('playerId');
    // print("Playerid " + playerId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: GestureDetector(
        onTap: () {
          print(selectedList);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: kBaseColor),
              padding: EdgeInsets.all(20),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 35.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Center(child: Text("Sport Selection")),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: k20Margin,
              ),
              Center(
                child: Text(
                  "Choose Sport",
                  style: const TextStyle(
                    color: kBaseColor,
                    fontStyle: FontStyle.normal,
                    fontSize: 40.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 700,
                child: FutureBuilder<List<Data>>(
                  future: getSports(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return sportItem(snapshot.data![index]);
                          });
                    } else if (snapshot.hasError) {
                      return Text("Error");
                    }
                    return Text("Loading...");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  goToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => MainNavigation()));
  }

  Future<List<Data>> getSports() async {
    APICall apiCall = new APICall();
    List<Data> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SportData sportData = await apiCall.getSports();

      if (sportData.data != null) {
        data.addAll(sportData.data!);
      }
    } else {}
    return data;
  }

  var _value = true;
  var currentSelectedSport;
  var selectedList = [];

  sportItem(dynamic data) {
    return GestureDetector(
      onTap: () {
        // if (_value) {
        //   _value = false;
        // } else {
        //   _value = true;
        // }
        //setState(() {});
        print("${data.id}");
        currentSelectedSport = data.id;
        // var estateSelected =
        // selectedList.firstWhere((value) => value == currentSelectedSport);
        // selectedList.removeWhere((element) => currentSelectedSport);
        //bool isAvailable = selectedList.any((element) => element = currentSelectedSport);

        for (int i = 0; i < selectedList.length; i++) {
          if (selectedList[i] == currentSelectedSport) {
            print("Found double");
            selectedList.remove(currentSelectedSport);
            setState(() {});
            return;
          } else {}
        }
        selectedList.add(currentSelectedSport);
        // print("Available $isAvailable");

        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 130,
        height: 130,
        decoration: kContainerBox.copyWith(
            color: selectedList.any((element) => element == data.id)
                ? kBaseColor
                : Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: selectedList.any((element) => element == data.id)
                          ? Icon(
                              Icons.check,
                              size: 15.0,
                              color: kBaseColor,
                            )
                          : SizedBox(
                              height: 15.0,
                            )),
                ),
              ],
            ),
            // Icon(
            //   Icons.check_circle,
            //   color: Colors.white,
            // ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                data.sportName,
                style: TextStyle(
                    color: selectedList.any((element) => element == data.id)
                        ? Colors.white
                        : kBaseColor,
                    fontSize: 18.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  height: 50,
                  width: 50,
                  child: Image.network(
                      "http://simpleicon.com/wp-content/uploads/football.png"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
