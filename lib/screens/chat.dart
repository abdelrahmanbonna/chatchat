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
  TextEditingController chatField;
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    var _user = Provider.of<UserData>(context);
    var _chat = Provider.of<ChatData>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                ChatChat.phone,
                color: _theme.getCurrentColor(),
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
                    fontSize: 12,
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
            Container(
              width: screen.width,
              //TODO add stream of messages
              child: null,
            ),
            Container(
              width: screen.width * 0.8,
              height: screen.height * 0.1,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black, blurRadius: 10, spreadRadius: 3),
                ],
                color: _theme.getThemeData().hintColor,
              ),
              child: Row(
                children: [
                  Container(
                    width: screen.width * 0.4,
                    child: TextField(
                      onChanged: (value) {
                        msg = value;
                      },
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      controller: chatField,
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        ChatChat.paper_plane,
                        size: 3,
                      ),
                      onPressed: () {
                        _chat.sendChatMessage(
                            _user.getUserId(), _chat.getReceiverId(), msg);
                        chatField.clear();
                      }),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
