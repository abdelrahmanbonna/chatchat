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
        ChangeNotifierProvider.value(value: ThemeChanger()),
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
      },
      initialRoute: Start.id,
      theme: _theme.getThemeData(),
    );
  }
}
