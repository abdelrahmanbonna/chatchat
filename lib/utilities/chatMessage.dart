import 'package:chatchat/logic/themeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final bool senderOrReceiver;
  final String sender, dateTimeStamp, message;

  ChatMessage(
      {this.message, this.dateTimeStamp, this.sender, this.senderOrReceiver});

  @override
  Widget build(BuildContext context) {
    var _theme = Provider.of<ThemeChanger>(context);

    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: senderOrReceiver
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: _theme.getThemeData().textTheme.subtitle2,
          ),
          Material(
            borderRadius: senderOrReceiver
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 10.0,
            color: senderOrReceiver
                ? _theme.getThemeData().primaryColor
                : _theme.getThemeData().accentColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                message,
                style: _theme
                    .getThemeData()
                    .textTheme
                    .subtitle1
                    .copyWith(color: _theme.getCurrentColor()),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              dateTimeStamp,
              style: _theme.getThemeData().textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }
}
