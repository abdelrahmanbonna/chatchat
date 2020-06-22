import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/utilities/chat_chat_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  static String id = "chat";
  static String userToken, receiverToken;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                ChatChat.phone,
                color: _theme.getCurrentColor(),
              ),
              onPressed: () {})
        ],
        title: Text(
          "Chat",
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
