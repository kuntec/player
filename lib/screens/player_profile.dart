import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:player/components/rounded_button.dart';
import 'package:player/constant/constants.dart';

class PlayerProfile extends StatefulWidget {
  const PlayerProfile({Key? key}) : super(key: key);

  @override
  _PlayerProfileState createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  File? file;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
      print(file!.path);
    });
  }

  uploadFile() {
    if (file == null) return;
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Player"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RoundedButton(
              title: "Select File",
              color: kAppColor,
              onPressed: () {
                selectFile();
              },
              minWidth: 200,
              txtColor: Colors.white,
            ),
            SizedBox(height: k20Margin),
            //Text(fileName),
            SizedBox(height: k20Margin),
            RoundedButton(
              title: "Upload File",
              color: kAppColor,
              onPressed: () {},
              minWidth: 200,
              txtColor: Colors.white,
            ),
          ],
        ),
      ),
    ));
  }
}
