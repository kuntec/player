import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var name;
  var number;
  var gender;
  var age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Payment")),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Fill your details",
                style: TextStyle(color: Colors.black87, fontSize: 18.0),
              ),
              SizedBox(height: kMargin),
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(
                    labelText: "Enter Your Name",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              SizedBox(height: kMargin),
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  number = value;
                },
                decoration: InputDecoration(
                    labelText: "Contact Number",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              SizedBox(height: kMargin),
              Text("Gender"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Radio(
                      value: "Male",
                      groupValue: gender,
                      onChanged: (value) {
                        gender = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: GestureDetector(
                        onTap: () {
                          gender = "Male";
                          setState(() {});
                        },
                        child: Text("Male")),
                  ),
                  Expanded(
                    flex: 10,
                    child: Radio(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (value) {
                        gender = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: GestureDetector(
                      onTap: () {
                        gender = "Female";
                        setState(() {});
                      },
                      child: Text("Female"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 30,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        age = value;
                      },
                      decoration: InputDecoration(
                          labelText: "Age",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: k20Margin),
              Container(
                margin: EdgeInsets.only(left: k20Margin, right: k20Margin),
                child: RoundedButton(
                  title: "Proceed To Payment",
                  color: kBaseColor,
                  txtColor: Colors.white,
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    print(
                        "name $name, contact $number, gender $gender, age $age");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
