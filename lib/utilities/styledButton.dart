import 'package:chatchat/logic/themeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StyledButton extends StatelessWidget {
  final Function function;
  final String text;
  StyledButton({this.function, this.text});

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var theme = Provider.of<ThemeChanger>(context).getThemeData();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: screen.width * 0.5,
        height: screen.height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19.0),
          color: theme.accentColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: MaterialButton(
          minWidth: screen.width * 0.5,
          height: screen.height * 0.07,
          onPressed: function,
          child: Text(
            text == null ? "Empty Button" : text,
            style: theme.textTheme.button,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
