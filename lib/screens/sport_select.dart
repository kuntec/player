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
      appBar: AppBar(
        title: Text("SPORT SELECT"),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: "Home",
      //         backgroundColor: Colors.blue),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: "Home",
      //         backgroundColor: Colors.blue),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: "Home",
      //         backgroundColor: Colors.blue),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: "Home",
      //         backgroundColor: Colors.blue)
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: k20Margin,
              ),
              Text(
                "SELECT YOUR FAVORITE SPORTS",
                style: const TextStyle(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.8,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Search'),
                      cursorColor: kBaseColor,
                    ),
                    SizedBox(
                      height: k20Margin,
                    ),
                    CheckboxListTile(
                      value: checked,
                      title: Text("Cricket"),
                      onChanged: (value) {
                        setState(() {
                          checked = value;
                        });
                      },
                    ),
                    RoundedButton(
                      title: "CONTINUE",
                      color: kBaseColor,
                      txtColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        goToHome();
                      },
                    ),
                  ],
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

  getSports() async {
    APICall apiCall = new APICall();
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      SportData sportData = await apiCall.getSports();
    } else {}
  }
}
