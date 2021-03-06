import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/utilities/styledButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  static String id = "about";

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
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
                  StyledButton(
                    text: "Github",
                    function: () {
                      _launchURL(
                          "https://github.com/abdelrahmanbonna/chatchat");
                    },
                  ),
                  Text(
                    "Under BSD-3-Clause License \n"
                    "Copyright (c) 2020, Abdelrahman Bonna \nAll rights reserved.",
                    style: _theme.getThemeData().textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
