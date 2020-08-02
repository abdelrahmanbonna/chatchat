import 'package:chatchat/logic/chatData.dart';
import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/models/user.dart';
import 'package:chatchat/utilities/cardItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'chat.dart';

class NewChat extends StatefulWidget {
  static String id = "newchat";

  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    var _fire = Firestore.instance;
    var _chat = Provider.of<ChatData>(context);

    return Scaffold(
      backgroundColor: _theme.getCurrentColor(),
      appBar: AppBar(
        title: Text(
          "Add new chat",
          style: _theme
              .getThemeData()
              .textTheme
              .headline1
              .merge(TextStyle(color: _theme.getCurrentColor())),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 15),
          //TODO add StreamBuilder of contacts
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: _fire.collection("users").snapshots(),
              builder: (context, snapshot) {
                List<User> list = [];
                if (snapshot == null) {
                  return ModalProgressHUD(
                    inAsyncCall: true,
                    child: Container(
                      color: _theme.getCurrentColor(),
                      width: screen.width,
                    ),
                  );
                } else {
                  var users = snapshot.data.documents;
                  for (var user in users) {
                    var userID = user.data['id'].toString();
                    var userName = user.data['name'].toString();
                    var userPic = user.data['picUrl'].toString();
                    var otherUser = User(id: userID);
                    otherUser.setName(userName);
                    otherUser.setPic(userPic);
                    list.add(otherUser);
                  }
                  return AnimatedList(
                    itemBuilder: (context, index, animation) {
                      return CardItem(
                        animation: animation,
                        pic: list[index].getPic(),
                        name: list[index].getName(),
                        onTap: () {
                          _chat.setReceiver(list[index].id,
                              list[index].getName(), list[index].getPic());
                          Navigator.pushNamed(context, Chat.id);
                        },
                      );
                    },
                    initialItemCount: list.length,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
