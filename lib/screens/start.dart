import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/utilities/styledButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Start extends StatelessWidget {
  static String id = "start";

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
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
            StyledButton(
              text: "Register",
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}
