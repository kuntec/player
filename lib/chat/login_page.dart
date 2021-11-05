import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:player/allWidgets/loading_view.dart';
import 'package:player/chat/home_page.dart';
import 'package:player/chatprovider/auth_provider.dart';
import 'package:player/constant/constants.dart';
import 'package:player/screens/main_navigation.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in Fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in Canceled");
        break;

      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in Success");
        break;
      default:
        break;
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset("assets/images/dream11.png"),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () async {
                bool isSuccess = await authProvider.handleSignIn();
                if (isSuccess) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
              child: Container(
                height: 40,
                width: 150,
                color: kBaseColor,
                child: Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              child: authProvider.status == Status.authenticating
                  ? LoadingView()
                  : SizedBox.shrink()),
        ],
      ),
    );
  }
}
