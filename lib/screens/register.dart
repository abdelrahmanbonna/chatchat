import 'dart:io';

import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/logic/userData.dart';
import 'package:chatchat/utilities/styledButton.dart';
import 'package:chatchat/utilities/styledField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  static String id = "register";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, phone, smsCode, verificationId;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(
        pickedFile.path,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    var _user = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: _theme.getCurrentColor(),
      appBar: AppBar(
        title: Text(
          "Register",
          style: _theme
              .getThemeData()
              .textTheme
              .headline1
              .merge(TextStyle(color: _theme.getCurrentColor())),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screen.width,
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  minRadius: 110,
                  maxRadius: 120,
                  backgroundImage: _image == null ? null : FileImage(_image),
                  child: Text(
                    _image == null ? "Press here to add Picture" : "",
                    style: _theme.getThemeData().textTheme.subtitle1,
                  ),
                ),
              ),
              SizedBox(
                width: screen.width,
                height: screen.height * 0.05,
              ),
              StyledField(
                textLabel: "Name",
                validate: (String value) {
                  if (value.isEmpty || value.length > 30) {
                    return "please enter a valid name (length of 1 to 30)";
                  }
                  return null;
                },
                onSave: (value) {
                  name = value;
                },
                inputType: TextInputType.text,
              ),
              StyledField(
                textLabel: "Phone",
                validate: (String value) {
                  if (value.isEmpty ||
                      RegExp("^(?:[+0]9)?[0-9]{10}\$").hasMatch(value)) {
                    return "please enter a valid number";
                  }
                  return null;
                },
                onSave: (value) {
                  phone = value;
                },
                inputType: TextInputType.phone,
              ),
              StyledButton(
                text: "Register",
                function: () {
                  //TODO remove comments
                  //_user.registerUser(context, name, phone,_image);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
