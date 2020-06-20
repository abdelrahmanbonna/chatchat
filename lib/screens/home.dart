import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/screens/about.dart';
import 'package:chatchat/utilities/chat_chat_icons.dart';
import 'package:chatchat/utilities/styledButton.dart';
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
        backgroundColor: _theme.getCurrentColor(),
        appBar: AppBar(
          title: Text(
            "Profile",
            style: _theme
                .getThemeData()
                .textTheme
                .headline1
                .merge(TextStyle(color: _theme.getCurrentColor())),
            textAlign: TextAlign.center,
          ),
        ),
      );

      //here for the second one
    } else if (index == 1) {
      return Scaffold(
        backgroundColor: _theme.getCurrentColor(),
        appBar: AppBar(
          title: Text(
            "Home",
            style: _theme
                .getThemeData()
                .textTheme
                .headline1
                .merge(TextStyle(color: _theme.getCurrentColor())),
            textAlign: TextAlign.center,
          ),
        ),
      );

      //here for the last one
    } else if (index == 2) {
      return Scaffold(
        backgroundColor: _theme.getCurrentColor(),
        appBar: AppBar(
          title: Text(
            "Settings",
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
            padding: EdgeInsets.symmetric(vertical: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.transparent,
                  child: Row(),
                ),
                StyledButton(
                  text: "About",
                  function: () {
                    Navigator.pushNamed(context, About.id);
                  },
                ),
                StyledButton(
                  text: "Logout",
                  function: () {},
                ),
              ],
            ),
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
      body: screensChanger(context, barIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _theme.getThemeData().accentColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: _theme.getCurrentColor(),
        selectedItemColor: _theme.getThemeData().primaryColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(
              ChatChat.user,
            ),
          ),
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(
              ChatChat.house,
            ),
          ),
          BottomNavigationBarItem(
            title: Text("Settings"),
            icon: Icon(
              ChatChat.gear,
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
