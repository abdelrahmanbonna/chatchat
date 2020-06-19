import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  ThemeData _themeData = ThemeData(
    primaryColor: Color(0xffD84797),
    accentColor: Color(0xff3ABEFF),
    bottomAppBarColor: Color(0xff3ABEFF),
    primaryColorDark: Color(0xff002243),
    primaryColorLight: Color(0xffFFFFFF),
    buttonColor: Color(0xff3ABEFF),
    appBarTheme: AppBarTheme(color: Color(0xffD84797)),
    hintColor: Color(0xff8983CB),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold), //headers
      subtitle1: TextStyle(
          color: Color(0xff8983CB),
          fontSize: 16,
          fontWeight: FontWeight.w700), //titles in comp
      subtitle2:
          TextStyle(color: Color(0xff8983CB), fontSize: 12), //date in chat
      button: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold), //buttons
      bodyText1: TextStyle(
          color: Color(0xff8983CB), fontSize: 20), //any text in the app
      bodyText2: TextStyle(
          color: Color(0xff8983CB),
          fontSize: 20,
          fontWeight: FontWeight.bold), //any text in fields
    ),
  );

  Color _currentColor;

  ThemeChanger() {
    setCurrentColor("light");
  }

  ThemeData getThemeData() => _themeData;
  Color getCurrentColor() => _currentColor;

  setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  setCurrentColor(String mode) {
    mode == "dark"
        ? _currentColor = _themeData.primaryColorDark
        : _currentColor = _themeData.primaryColorLight;
  }
}
