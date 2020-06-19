import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/utilities/styledButton.dart';
import 'package:chatchat/utilities/styledField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  static String id = "register";

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
      backgroundColor: _theme.getCurrentColor(),
      appBar: AppBar(
        title: Text(
          "Register",
          style: _theme.getThemeData().textTheme.headline1,
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
              StyledField(
                textLabel: "Name",
              ),
              StyledField(
                textLabel: "Phone",
                validate: (value) {
                  if (value.isEmpty ||
                      RegExp("^(?:[+0]9)?[0-9]{10}\$").hasMatch(value)) {
                    return "please enter a valid number";
                  }
                  return null;
                },
                onSave: () {},
              ),
              StyledButton(
                text: "Register",
                function: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
