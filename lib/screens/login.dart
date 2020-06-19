import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/utilities/styledButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  static String id = "login";

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: screen.width,
            ),
            Image.asset("assets/Logo.png"),
            SizedBox(
              height: screen.height * 0.15,
            ),
            StyledButton(
              text: "Login",
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}
