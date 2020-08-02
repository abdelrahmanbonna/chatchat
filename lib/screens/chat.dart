import 'package:chatchat/logic/chatData.dart';
import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/logic/userData.dart';
import 'package:chatchat/utilities/chat_chat_icons.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  static String id = "chat";

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String msg = '';

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    var _user = Provider.of<UserData>(context);
    var _chat = Provider.of<ChatData>(context);

    return Scaffold(
      backgroundColor: _theme.getCurrentColor(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                ChatChat.phone,
                color: _theme.getCurrentColor(),
                size: 250,
              ),
              onPressed: () {
                //TODO start voice call
              })
        ],
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              minRadius: 10,
              maxRadius: 18,
              backgroundImage: FirebaseImage(_user.getPic(),
                  shouldCache: true,
                  maxSizeBytes: 10000 * 1000,
                  cacheRefreshStrategy: CacheRefreshStrategy.NEVER),
            ),
            SizedBox(
              width: screen.width * 0.01,
            ),
            Text(
              _chat.getReceiverName() == null
                  ? "Chat"
                  : _chat.getReceiverName(),
              style: _theme.getThemeData().textTheme.headline1.merge(TextStyle(
                    color: _theme.getCurrentColor(),
                    fontSize: 14,
                  )),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                //TODO add stream of messages
                child: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                alignment: Alignment.center,
                width: screen.width * 0.9,
                height: screen.height * 0.07,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(33.0),
                  color: _theme.getThemeData().hintColor,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(-0x29000000),
                      blurRadius: 9,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: screen.width * 0.01,
                    ),
                    Container(
                      width: screen.width * 0.6,
                      child: TextField(
                        style:
                            _theme.getThemeData().textTheme.subtitle1.copyWith(
                                  color: _theme.getCurrentColor(),
                                ),
                        decoration: InputDecoration(
                          fillColor: _theme.getCurrentColor(),
                          hoverColor: _theme.getCurrentColor(),
                          hintText: "Enter a message..",
                          hintStyle: _theme
                              .getThemeData()
                              .textTheme
                              .subtitle1
                              .copyWith(
                                color: _theme.getCurrentColor(),
                              ),
                        ),
                        onChanged: (value) {
                          msg = value;
                        },
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    IconButton(
                        alignment: Alignment.center,
                        icon: Icon(
                          ChatChat.paper_plane,
                          size: 35,
                          color: _theme.getCurrentColor(),
                        ),
                        onPressed: () {
                          _chat.sendChatMessage(
                              _user.getUserId(), _chat.getReceiverId(), msg);
                          setState(() {
                            msg = "";
                          });
                        }),
                    SizedBox(
                      width: screen.width * 0.01,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
