import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/utilities/chat_chat_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static String id = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int barIndex = 1;

  Widget screensChanger(BuildContext context, int index) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);

    // if first option of the bar has been clicked
    if (index == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: _theme.getThemeData().textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ),
      );

      //here for the second one
    } else if (index == 1) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: _theme.getThemeData().textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ),
      );

      //here for the last one
    } else if (index == 2) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: _theme.getThemeData().textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Container(
        color: _theme.getCurrentColor(),
      );
    }
  }

  // Main of the screen where the bar is and it's functions
  @override
  Widget build(BuildContext context) {
    var _theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
      backgroundColor: _theme.getCurrentColor(),
      body: screensChanger(context, barIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _theme.getThemeData().accentColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: _theme.getThemeData().hintColor,
        items: [
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(
              ChatChat.user,
              color: _theme.getCurrentColor(),
            ),
          ),
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(
              ChatChat.house,
              color: _theme.getCurrentColor(),
            ),
          ),
          BottomNavigationBarItem(
            title: Text("Settings"),
            icon: Icon(
              ChatChat.gear,
              color: _theme.getCurrentColor(),
            ),
          ),
        ],
        currentIndex: barIndex,
        onTap: (value) {
          setState(() {
            barIndex = value;
          });
        },
      ),
    );
  }
}
