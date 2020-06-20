import 'package:chatchat/logic/themeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class About extends StatelessWidget {
  static String id = "about";

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
        backgroundColor: _theme.getCurrentColor(),
        appBar: AppBar(
          title: Text(
            "About",
            style: _theme
                .getThemeData()
                .textTheme
                .headline1
                .merge(TextStyle(color: _theme.getCurrentColor())),
            textAlign: TextAlign.center,
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/Logo.png"),
              SizedBox(
                height: screen.height * 0.1,
              ),
              Text(
                "ChatChat app is a flutter chat app which uses firebase to handle it's backend.\n"
                "You could send messages and make calls with this app.\n",
                style: _theme.getThemeData().textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              Text(
                "Made by Abdelrahman Bonna\n",
                style: _theme.getThemeData().textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )));
  }
}
