import 'package:chatchat/logic/chatData.dart';
import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/logic/userData.dart';
import 'package:chatchat/utilities/chatMessage.dart';
import 'package:chatchat/utilities/chat_chat_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  static String id = "chat";

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String msg = '';
  Firestore _fire = Firestore.instance;

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
            SizedBox(
              width: screen.width * 0.02,
            ),
            Text(
              _chat.getReceiverName() == null
                  ? "Chat"
                  : _chat.getReceiverName(),
              style: _theme.getThemeData().textTheme.headline1.merge(TextStyle(
                    color: _theme.getCurrentColor(),
                    fontSize: 16,
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
                width: screen.width,
                //TODO add stream of messages
                child: StreamBuilder<QuerySnapshot>(
                  stream: _fire.collection('chat').snapshots(),
                  builder: (context, snapshot) {
                    List<Widget> list = [];
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.connectionState != ConnectionState.active) {
                      return ModalProgressHUD(
                          inAsyncCall: true,
                          child: Container(
                            color: _theme.getCurrentColor(),
                          ));
                    } else {
                      var chats = snapshot.data.documents;
                      for (var chatf in chats) {
                        if (chatf.documentID ==
                            "${_user.getUserId()}-${_chat.getReceiverId()}") {
                          var messages = chatf.data['messages'];
                          for (var msg in messages) {
                            if (msg['sender'].toString() == _user.getUserId()) {
                              list.add(ChatMessage(
                                senderOrReceiver: true,
                                message: msg['message'].toString(),
                                dateTimeStamp: msg['datetime'].toString(),
                                sender: _user.getName(),
                              ));
                            } else {
                              list.add(ChatMessage(
                                senderOrReceiver: false,
                                message: msg['message'].toString(),
                                dateTimeStamp: msg['datetime'].toString(),
                                sender: _chat.getReceiverName(),
                              ));
                            }
                          }
                        } else if (chatf.documentID ==
                            "${_chat.getReceiverId()}-${_user.getUserId()}") {
                          var messages = chatf.data['messages'];
                          for (var msg in messages) {
                            if (msg['sender'].toString() == _user.getUserId()) {
                              list.add(ChatMessage(
                                senderOrReceiver: true,
                                message: msg['message'].toString(),
                                dateTimeStamp: msg['datetime'].toString(),
                                sender: _user.getName(),
                              ));
                            } else {
                              list.add(ChatMessage(
                                senderOrReceiver: false,
                                message: msg['message'].toString(),
                                dateTimeStamp: msg['datetime'].toString(),
                                sender: _chat.getReceiverName(),
                              ));
                            }
                          }
                        }
                      }

                      return Column(
                        children: list,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                alignment: Alignment.center,
                width: screen.width * 0.9,
                height: screen.height * 0.07,
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
