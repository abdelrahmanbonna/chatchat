import 'package:chatchat/logic/themeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StyledField extends StatelessWidget {
  final String textLabel;
  final Function onSave;
  final TextInputType inputType;
  final bool secure;

  StyledField({this.textLabel, this.onSave, this.inputType, this.secure});

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      width: screen.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.0),
        color: Colors.transparent,
        border:
            Border.all(width: 2.0, color: _theme.getThemeData().accentColor),
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        enableSuggestions: true,
        style: _theme.getThemeData().textTheme.bodyText2,
        decoration: InputDecoration(
            alignLabelWithHint: false,
            hintText: "Enter " + textLabel,
            border: InputBorder.none,
            labelText: textLabel,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: _theme.getThemeData().textTheme.bodyText2,
            hintStyle: _theme.getThemeData().textTheme.bodyText2),
        keyboardType: inputType,
        onChanged: onSave,
        obscureText: secure,
      ),
    );
  }
}
