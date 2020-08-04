import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatchat/logic/chatData.dart';
import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/logic/userData.dart';
import 'package:chatchat/models/user.dart';
import 'package:chatchat/screens/about.dart';
import 'package:chatchat/screens/newChat.dart';
import 'package:chatchat/utilities/cardItem.dart';
import 'package:chatchat/utilities/chat_chat_icons.dart';
import 'package:chatchat/utilities/styledButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'chat.dart';
import 'start.dart';

class Home extends StatefulWidget {
  static String id = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int barIndex = 1;

  Widget screensChanger(BuildContext context, int index) {
    var screen = MediaQuery.of(context).size;
    var _theme = Provider.of<ThemeChanger>(context);
    var _user = Provider.of<UserData>(context);
    var _fire = Firestore.instance;
    var _chat = Provider.of<ChatData>(context);

    // if first option of the bar has been clicked
    if (index == 0) {
      return Scaffold(
        backgroundColor: _theme.getCurrentColor(),
        appBar: AppBar(
          title: Text(
            "Profile",
            style: _theme
                .getThemeData()
                .textTheme
                .headline1
                .merge(TextStyle(color: _theme.getCurrentColor())),
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  width: screen.width,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  minRadius: 110,
                  maxRadius: 120,
                  backgroundImage: FirebaseImage(_user.getPic(),
                      shouldCache: true,
                      maxSizeBytes: 10000 * 1000,
                      cacheRefreshStrategy: CacheRefreshStrategy.NEVER),
                ),
                SizedBox(
                  width: screen.width,
                  height: screen.height * 0.05,
                ),
                Container(
                  width: screen.width * 0.8,
                  height: 66.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33.0),
                    color: _theme.getCurrentColor(),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(-0x29000000),
                        blurRadius: 9,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'Name:',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 20,
                          color: const Color(0xff8983cb),
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: screen.width * 0.04,
                      ),
                      AutoSizeText(
                        _user.getName(),
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 20,
                          color: const Color(0xff8983cb),
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screen.height * 0.02,
                ),
                Container(
                  width: screen.width * 0.8,
                  height: 66.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33.0),
                    color: _theme.getCurrentColor(),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(-0x29000000),
                        blurRadius: 9,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'Phone:',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 20,
                          color: const Color(0xff8983cb),
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: screen.width * 0.04,
                      ),
                      AutoSizeText(
                        _user.getPhone(),
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 20,
                          color: const Color(0xff8983cb),
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screen.height * 0.02,
                ),
                Container(
                  width: screen.width * 0.8,
                  height: 66.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33.0),
                    color: _theme.getCurrentColor(),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(-0x29000000),
                        blurRadius: 9,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'Email:',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 20,
                          color: const Color(0xff8983cb),
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: screen.width * 0.04,
                      ),
                      AutoSizeText(
                        _user.getEmail(),
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: screen.width * 0.016,
                          color: const Color(0xff8983cb),
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      //here for the second one
    } else if (index == 1) {
      return Scaffold(
        backgroundColor: _theme.getCurrentColor(),
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  ChatChat.plus,
                  color: _theme.getCurrentColor(),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, NewChat.id);
                })
          ],
          title: Text(
            "Home",
            style: _theme
                .getThemeData()
                .textTheme
                .headline1
                .merge(TextStyle(color: _theme.getCurrentColor())),
            textAlign: TextAlign.center,
          ),
        ),
        body: SafeArea(
          child: Container(
            // show chats currently have messages
            child: StreamBuilder<QuerySnapshot>(
              stream: _fire.collection('chat').snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState != ConnectionState.active ||
                    snapshot.data == null) {
                  return ModalProgressHUD(
                    inAsyncCall: true,
                    child: Container(
                      color: _theme.getCurrentColor(),
                    ),
                  );
                } else {
                  List<User> list = [];
                  var chats = snapshot.data.documents;
                  for (var chat in chats) {
                    if (chat.data['sender'].toString() == _user.getUserId()) {
                      var wantedUsr = chat.data['receiver'].toString();
                      return StreamBuilder<QuerySnapshot>(
                          stream: _fire.collection('users').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot == null) {
                              return ModalProgressHUD(
                                inAsyncCall: true,
                                child: Container(
                                  color: _theme.getCurrentColor(),
                                ),
                              );
                            } else {
                              var usrs = snapshot.data.documents;
                              for (var usr in usrs) {
                                if (wantedUsr == usr.data["id"].toString()) {
                                  var otherUser =
                                      User(id: usr.data["id"].toString());
                                  otherUser
                                      .setName(usr.data["name"].toString());
                                  otherUser
                                      .setPic(usr.data["picUrl"].toString());
                                  list.add(otherUser);
                                }
                              }
                              return AnimatedList(
                                itemBuilder: (context, index, animation) {
                                  if (list.length == 0) {
                                    return Container(
                                      width: screen.width,
                                      height: screen.height * 0.5,
                                      color: _theme.getCurrentColor(),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "No Messages yet.",
                                        style: _theme
                                            .getThemeData()
                                            .textTheme
                                            .headline1
                                            .copyWith(
                                                color: _theme
                                                    .getThemeData()
                                                    .hintColor),
                                      ),
                                    );
                                  } else {
                                    return CardItem(
                                      animation: animation,
                                      onTap: () {
                                        _chat.setReceiver(
                                            list[index].id,
                                            list[index].getName(),
                                            list[index].getPic());
                                        Navigator.pushNamed(context, Chat.id);
                                      },
                                      onHold: () {
                                        //TODO add remove func
//                                        setState(() {
//                                          list.removeAt(index);
//                                        });
                                      },
                                      name: list[index].getName(),
                                      pic: list[index].getPic(),
                                    );
                                  }
                                },
                                initialItemCount: list.length,
                              );
                            }
                          });
                    } else if (chat.data['receiver'].toString() ==
                        _user.getUserId()) {
                      var wantedUsr = chat.data['sender'].toString();
                      return StreamBuilder<QuerySnapshot>(
                          stream: _fire.collection('users').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot == null) {
                              return ModalProgressHUD(
                                inAsyncCall: true,
                                child: Container(
                                  color: _theme.getCurrentColor(),
                                ),
                              );
                            } else {
                              var usrs = snapshot.data.documents;
                              for (var usr in usrs) {
                                if (wantedUsr == usr.data["id"].toString()) {
                                  var otherUser =
                                      User(id: usr.data["id"].toString());
                                  otherUser
                                      .setName(usr.data["name"].toString());
                                  otherUser
                                      .setPic(usr.data["picUrl"].toString());
                                  list.add(otherUser);
                                }
                              }
                              return AnimatedList(
                                itemBuilder: (context, index, animation) {
                                  if (list.length == 0) {
                                    return Container(
                                      width: screen.width,
                                      height: screen.height * 0.5,
                                      color: _theme.getCurrentColor(),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "No Messages yet.",
                                        style: _theme
                                            .getThemeData()
                                            .textTheme
                                            .headline1
                                            .copyWith(
                                                color: _theme
                                                    .getThemeData()
                                                    .hintColor),
                                      ),
                                    );
                                  } else {
                                    return CardItem(
                                      animation: animation,
                                      onHold: () {
                                        //TODO add remove func
//                                        setState(() {
//                                          list.removeAt(index);
//                                        });
                                      },
                                      onTap: () {
                                        _chat.setReceiver(
                                            list[index].id,
                                            list[index].getName(),
                                            list[index].getPic());
                                        Navigator.pushNamed(context, Chat.id);
                                      },
                                      name: list[index].getName(),
                                      pic: list[index].getPic(),
                                    );
                                  }
                                },
                                initialItemCount: list.length,
                              );
                            }
                          });
                    }
                  }
                }
              },
            ),
          ),
        ),
      );

      //here for the last one
    } else if (index == 2) {
      return Scaffold(
        backgroundColor: _theme.getCurrentColor(),
        appBar: AppBar(
          title: Text(
            "Settings",
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
            padding: EdgeInsets.symmetric(vertical: 120),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Text(
                          "Dark Mode",
                          style: _theme.getThemeData().textTheme.button.merge(
                              TextStyle(
                                  color: _theme.getThemeData().hintColor)),
                        ),
                        SizedBox(
                          width: screen.width * 0.1,
                        ),
                        Switch(
                          value: _theme.getSwitch(),
                          inactiveThumbColor: _theme.getThemeData().hintColor,
                          activeColor: _theme.getThemeData().hintColor,
                          activeTrackColor: _theme.getThemeData().hintColor,
                          onChanged: (value) {
                            _theme.setSwitch(value);
                            _theme.setCurrentColor();
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  SizedBox(
                    height: screen.height * 0.1,
                  ),
                  StyledButton(
                    text: "About",
                    function: () {
                      Navigator.pushNamed(context, About.id);
                    },
                  ),
                  StyledButton(
                    text: "Logout",
                    function: () {
                      _user.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, Start.id, (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: _theme.getCurrentColor(),
      );
    }
  }

  // Main of the screen where the bar is and it's functions
  @override
  Widget build(BuildContext context) {
    var _theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      body: screensChanger(context, barIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _theme.getThemeData().accentColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: _theme.getCurrentColor(),
        selectedItemColor: _theme.getThemeData().primaryColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(
              ChatChat.user,
            ),
          ),
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(
              ChatChat.house,
            ),
          ),
          BottomNavigationBarItem(
            title: Text("Settings"),
            icon: Icon(
              ChatChat.gear,
            ),
          ),
        ],
        currentIndex: barIndex,
        onTap: (value) {
          setState(() {
            barIndex = value;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
