import 'package:chatchat/logic/themeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewChat extends StatefulWidget {
  static String id = "newchat";

  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      backgroundColor: _theme.getCurrentColor(),
      appBar: AppBar(
        title: Text(
          "Add new chat",
          style: _theme
              .getThemeData()
              .textTheme
              .headline1
              .merge(TextStyle(color: _theme.getCurrentColor())),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
