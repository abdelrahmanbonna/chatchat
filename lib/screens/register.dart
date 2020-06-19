import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/utilities/styledButton.dart';
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
              height: screen.height * 0.15,
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
