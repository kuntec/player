import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';

class VenueRegister extends StatefulWidget {
  const VenueRegister({Key? key}) : super(key: key);

  @override
  _VenueRegisterState createState() => _VenueRegisterState();
}

class _VenueRegisterState extends State<VenueRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Your Ground"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [registerVenueForm()],
          ),
        ),
      ),
    );
  }

  Widget registerVenueForm() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) {
              //    name = value;
            },
            decoration: InputDecoration(
                labelText: "Ground Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              // description = value;
            },
            decoration: InputDecoration(
                labelText: "Address",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              // facilities = value;
            },
            decoration: InputDecoration(
                labelText: "City",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              //address = value;
            },
            decoration: InputDecoration(
                labelText: "Ground Type",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              // locationLink = value;
            },
            decoration: InputDecoration(
                labelText: "Contact Person Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              //city = value;
            },
            decoration: InputDecoration(
                labelText: "Primary Contact Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextField(
            onChanged: (value) {
              // sport = value;
            },
            decoration: InputDecoration(
                labelText: "Secondary Contact Number",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          SizedBox(height: 20.0),
          TextField(
            enabled: false,
            decoration: InputDecoration(
                labelText: "About Your Ground",
                labelStyle: TextStyle(
                  color: Colors.grey,
                )),
          ),
          TextFormField(
              onChanged: (value) {
                // sport = value;
              },
              minLines: 3,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                labelText: "",
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
              )),
          SizedBox(height: k20Margin),
          RoundedButton(
            title: "Register Ground",
            color: kBaseColor,
            txtColor: Colors.white,
            minWidth: 250,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
