import 'package:chatchat/logic/chatData.dart';
import 'package:chatchat/logic/userData.dart';
import 'package:chatchat/screens/about.dart';
import 'package:chatchat/screens/chat.dart';
import 'package:chatchat/screens/forgetpass.dart';
import 'package:chatchat/screens/home.dart';
import 'package:chatchat/screens/login.dart';
import 'package:chatchat/screens/newChat.dart';
import 'package:chatchat/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logic/themeChanger.dart';
import 'screens/start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialAppWithTheme(),
      providers: [
        ChangeNotifierProvider.value(
          value: ThemeChanger(),
        ),
        ChangeNotifierProvider.value(
          value: ChatData(),
        ),
        ChangeNotifierProvider.value(
          value: UserData(),
        ),
      ],
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Start.id: (context) => Start(),
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        Home.id: (context) => Home(),
        About.id: (context) => About(),
        Chat.id: (context) => Chat(),
        NewChat.id: (context) => NewChat(),
        ForgetPass.id: (context) => ForgetPass(),
      },
      initialRoute: Start.id,
      theme: _theme.getThemeData(),
    );
  }
}
