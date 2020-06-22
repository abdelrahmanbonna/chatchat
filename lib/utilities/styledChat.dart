import 'package:chatchat/logic/themeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StyledChatContact extends StatelessWidget {
  final String picPath, name;
  final Function func;

  StyledChatContact({this.name, this.picPath, this.func});

  @override
  Widget build(BuildContext context) {
    var _theme = Provider.of<ThemeChanger>(context);
    var screen = MediaQuery.of(context).size;

    return Container(
      width: screen.width * 0.8,
      height: 75.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29.0),
        color: _theme.getCurrentColor(),
        boxShadow: [
          BoxShadow(
            color: const Color(-0x4d000000),
            blurRadius: 10,
          ),
        ],
      ),
      child: FlatButton(
        onPressed: func,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(picPath),
              ),
            ),
            SizedBox(
              width: screen.width * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: _theme
                      .getThemeData()
                      .textTheme
                      .headline1
                      .merge(TextStyle(color: _theme.getThemeData().hintColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
