import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/logic/userData.dart';
import 'package:chatchat/screens/start.dart';
import 'package:chatchat/utilities/styledButton.dart';
import 'package:chatchat/utilities/styledField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  static String id = "register";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, phone, smsCode, verificationId;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var _theme = Provider.of<ThemeChanger>(context);

        return AlertDialog(
          title: new Text(
            "Registration is done",
            style: _theme
                .getThemeData()
                .textTheme
                .headline1
                .merge(TextStyle(color: _theme.getThemeData().hintColor)),
          ),
          content: new Text("Your account has been made please login"),
          backgroundColor: _theme.getCurrentColor(),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.popAndPushNamed(context, Start.id);
              },
            ),
          ],
        );
      },
    );
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
              CircleAvatar(
                backgroundColor: Colors.grey,
                minRadius: 110,
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
              ),
              StyledButton(
                text: "Register",
                function: () {
                  //TODO remove comments
                  //_user.registerUser(context, name, phone);
                  //TODO find a solution to knowing whether the user is registered or not
                  _showDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
