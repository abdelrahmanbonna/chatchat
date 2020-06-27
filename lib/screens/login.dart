import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/logic/userData.dart';
import 'package:chatchat/screens/forgetpass.dart';
import 'package:chatchat/utilities/styledButton.dart';
import 'package:chatchat/utilities/styledField.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static String id = "login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, _pass;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    var _user = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: _theme
              .getThemeData()
              .textTheme
              .headline1
              .merge(TextStyle(color: _theme.getCurrentColor())),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: _theme.getCurrentColor(),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: screen.width,
                ),
                Hero(
                    tag: "logo",
                    child: Image.asset(
                      "assets/Logo.png",
                      scale: 0.89,
                    )),
                SizedBox(
                  height: screen.height * 0.1,
                ),
                StyledField(
                  textLabel: "Email",
                  onSave: (String value) {
                    email = value;
                  },
                  secure: false,
                  inputType: TextInputType.emailAddress,
                ),
                StyledField(
                  textLabel: "Password",
                  onSave: (String value) {
                    _pass = value;
                  },
                  inputType: TextInputType.visiblePassword,
                  secure: true,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgetPass.id);
                    },
                    child: Text(
                      "Forgot password",
                      style: _theme.getThemeData().textTheme.subtitle1,
                    )),
                StyledButton(
                  text: "Login",
                  function: () async {
                    setState(() {
                      loading = true;
                    });
                    _user.login(email, _pass, context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
