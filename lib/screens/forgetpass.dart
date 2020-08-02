import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/logic/userData.dart';
import 'package:chatchat/utilities/styledButton.dart';
import 'package:chatchat/utilities/styledField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPass extends StatelessWidget {
  static String id = "forget";

  @override
  Widget build(BuildContext context) {
    String email;
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    var _user = Provider.of<UserData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forget Password",
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
          padding: EdgeInsets.symmetric(
            vertical: 90,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screen.width,
              ),
              Text(
                "Please enter your Email",
                style: _theme.getThemeData().textTheme.subtitle1,
              ),
              StyledField(
                textLabel: "Email",
                inputType: TextInputType.emailAddress,
                secure: false,
                onSave: (value) {
                  email = value;
                },
              ),
              StyledButton(
                text: "Submit",
                function: () {
                  _user.forgetPass(email, context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
