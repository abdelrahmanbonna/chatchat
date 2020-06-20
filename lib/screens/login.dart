import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/screens/home.dart';
import 'package:chatchat/utilities/styledButton.dart';
import 'package:chatchat/utilities/styledField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static String id = "login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phone;

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: _theme.getThemeData().textTheme.headline1,
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: _theme.getCurrentColor(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screen.width,
              ),
              Image.asset("assets/Logo.png"),
              SizedBox(
                height: screen.height * 0.1,
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
                onSave: (String value) {
                  phone = value;
                },
              ),
              StyledButton(
                text: "Login",
                function: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Home.id, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
