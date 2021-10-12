import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/looking_for_data.dart';

class AddHost extends StatefulWidget {
  const AddHost({Key? key}) : super(key: key);

  @override
  _AddHostState createState() => _AddHostState();
}

class _AddHostState extends State<AddHost> {
  late String valueChoose;
  List sports = [
    "Cricket",
    "Football",
    "Vollyball",
    "Badminton",
  ];
  String dropdownValue = 'Select Sport';

  String lookingForValue = 'Looking For';
  late LookingFor _selectedLK = new LookingFor();
  late List<LookingFor> looks;

  Future<List<LookingFor>> getLookingFor() async {
    APICall apiCall = new APICall();
    List<LookingFor> list = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      LookingForData lookingForData = await apiCall.getLookingFor();
      if (lookingForData.lookingFor != null) {
        list = lookingForData.lookingFor!;
        this._selectedLK = list[0];
      }
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLookingFor();
  }

  Widget buildData(List<LookingFor> data) {
    return DropdownButton<LookingFor>(
      value: _selectedLK,
      hint: Text("Select Looking For"),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: kAppColor,
      ),
      onChanged: (LookingFor? newValue) {
        // this._selectedLK = newValue!;
        setState(() {
          this._selectedLK = newValue!;
        });
      },
      items: data.map<DropdownMenuItem<LookingFor>>((LookingFor value) {
        return DropdownMenuItem<LookingFor>(
          value: value,
          child: Text(value.lookingFor!),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Host Activity"),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            width: 100,
            height: 300,
            child: Center(
              child: Text(
                "My Games",
                style: TextStyle(color: kAppColor, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
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
              // Text(
              //   "KINDLY ADD YOUR DETAILS",
              //   style: const TextStyle(
              //     color: const Color(0xff000000),
              //     fontWeight: FontWeight.w600,
              //     fontFamily: "Roboto",
              //     fontStyle: FontStyle.normal,
              //     fontSize: 20.8,
              //   ),
              //   textAlign: TextAlign.left,
              // ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: kContainerBoxDecoration,
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    FutureBuilder<List<LookingFor>>(
                        future: getLookingFor(),
                        builder: (context, snapshot) {
                          final data = snapshot.data;
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            default:
                              if (snapshot.hasError) {
                                return Text("Some Error");
                              } else {
                                return buildData(data!);
                              }
                          }
                          return buildData(data!);
                        }),

                    // DropdownButton<LookingFor>(
                    //   value: selectedLK,
                    //   isExpanded: true,
                    //   icon: const Icon(Icons.keyboard_arrow_down),
                    //   iconSize: 24,
                    //   elevation: 16,
                    //   style: const TextStyle(color: Colors.deepPurple),
                    //   underline: Container(
                    //     height: 2,
                    //     color: kAppColor,
                    //   ),
                    //   onChanged: (LookingFor? newValue) {
                    //     setState(() {
                    //       selectedLK = newValue!;
                    //     });
                    //   },
                    //   items: looks.map<DropdownMenuItem<LookingFor>>(
                    //       (LookingFor value) {
                    //     return DropdownMenuItem<LookingFor>(
                    //       value: value,
                    //       child: Text(value.lookingFor!),
                    //     );
                    //   }).toList(),
                    // ),

                    DropdownButton<String>(
                      value: dropdownValue,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: kAppColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Select Sport',
                        'Cricket',
                        'Football',
                        'Badminton',
                        'Tennis'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: k20Margin),
                    // FutureBuilder<List<LookingFor>>(
                    //     future: getLookingFor(),
                    //     builder: (context, snapshot) {
                    //       final data = snapshot.data;
                    //       switch (snapshot.connectionState) {
                    //         case ConnectionState.waiting:
                    //           return CircularProgressIndicator();
                    //         default:
                    //           if (snapshot.hasError) {
                    //             return Text("Some Error");
                    //           } else {
                    //             return buildData(data!);
                    //           }
                    //       }
                    //       return buildData(data!);
                    //     }),
                    // FutureBuilder<dynamic>(
                    //     future: getLookingFor(),
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot<dynamic> snapshot) {
                    //       if (snapshot.hasData) {
                    //         print(snapshot.data!.lookingFor!.length);
                    //         return DropdownButton<dynamic>(
                    //           value: selectedLK,
                    //           hint: Text("Select Looking For"),
                    //           onChanged: (value) {
                    //             selectedLK = value;
                    //           },
                    //           items: snapshot.data!.lookingFor
                    //               .map(
                    //                 (lk) => DropdownMenuItem<dynamic>(
                    //                   child: Text(lk.lookingFor!),
                    //                   value: lk.lookingForValue,
                    //                 ),
                    //               )
                    //               .toList(),
                    //         );
                    //       } else {
                    //         return Text("No Data");
                    //       }
                    //     }),

                    // DropdownButton(
                    //   value: lookingForValue,
                    //   hint: Text("Select Looking For"),
                    //   onChanged: (value) {
                    //     lookingForValue = value.toString();
                    //   },
                    //   items: looks
                    //       .map(
                    //         (map) => DropdownMenuItem(
                    //           child: Text(map.lookingFor!),
                    //           value: map.lookingForValue,
                    //         ),
                    //       )
                    //       .toList(),
                    // ),
                    SizedBox(height: k20Margin),
                    DropdownButton<String>(
                      value: lookingForValue,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: kAppColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          lookingForValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Looking For',
                        'Opponent To Play',
                        'Team to Join',
                        'Player to Join',
                        'Team Player to Join'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: k20Margin),
                    TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'AREA'),
                      cursorColor: kBaseColor,
                    ),
                    SizedBox(height: k20Margin),
                    TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'DATE'),
                      cursorColor: kBaseColor,
                    ),
                    SizedBox(
                      height: k20Margin,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'TIME'),
                      cursorColor: kBaseColor,
                    ),
//                    Text("Select Gender"),
                    SizedBox(
                      height: k20Margin,
                    ),

                    RoundedButton(
                      title: "CREATE ACTIVITY",
                      color: kBaseColor,
                      txtColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        print(this._selectedLK.lookingForValue!);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
