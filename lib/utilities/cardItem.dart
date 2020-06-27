import 'package:chatchat/logic/themeChanger.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
      @required this.animation,
      @required this.onTap,
      @required this.name,
      @required this.pic})
      : assert(animation != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final String name;
  final String pic;

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    TextStyle textStyle = _theme
        .getThemeData()
        .textTheme
        .headline4
        .merge(TextStyle(color: _theme.getThemeData().hintColor));

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 80.0,
            child: Card(
              color: _theme.getCurrentColor(),
              child: Center(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      minRadius: 20,
                      maxRadius: 20,
                      backgroundImage: FirebaseImage(pic,
                          shouldCache: true,
                          maxSizeBytes: 10000 * 1000,
                          cacheRefreshStrategy: CacheRefreshStrategy.NEVER),
                    ),
                    SizedBox(
                      width: screen.width * 0.01,
                    ),
                    Text('$name', style: textStyle),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
