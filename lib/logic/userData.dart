import 'dart:io';

import 'package:chatchat/logic/themeChanger.dart';
import 'package:chatchat/models/user.dart';
import 'package:chatchat/screens/home.dart';
import 'package:chatchat/screens/start.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserData extends ChangeNotifier {
  User _user;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _store = FirebaseStorage.instance;
  Firestore _fire = Firestore.instance;

  UserData();

  String getName() => _user.getName();
  String getPhone() => _user.getPhone();
  String getPic() => _user.getPic();
  String getEmail() => _user.getEmail();
  String getUserId() => _user.id;

  setName(String name) {
    _user.setName(name);
    notifyListeners();
  }

  setPhone(String phone) {
    _user.setPhone(phone);
    notifyListeners();
  }

  setPic(String pic) {
    _user.setPic(pic);
    notifyListeners();
  }

  setEmail(String email) {
    _user.setEmail(email);
    notifyListeners();
  }

  logout() {
    _auth.signOut();
    _user = User(id: "0");
    notifyListeners();
  }

  Future uploadFile(File _image, String id) async {
    StorageReference storageReference =
        _store.ref().child('profilepics/$id.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
  }

  registerUser(
    String name,
    String password,
    String email,
    String phone,
    File pic,
    BuildContext context,
  ) async {
    // var user;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      var user = await _auth.currentUser();
      uploadFile(pic, user.uid);
      await _fire.collection('users').document(user.uid).setData({
        'id': user.uid,
        'email': user.email,
        'name': name.toString(),
        'phone': phone.toString(),
        'picUrl':
            "gs://chatchat-5e6e6.appspot.com/profilepics/${user.uid.toString()}.jpg",
      });

      await _auth.signOut();
      _showDialog(context);
    } on Exception catch (e) {
      _showDialogFail(context, e);
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var _theme = Provider.of<ThemeChanger>(context);

        return AlertDialog(
          title: new Text(
            "Registration is done",
            style: _theme
                .getThemeData()
                .textTheme
                .headline1
                .merge(TextStyle(color: _theme.getThemeData().hintColor)),
          ),
          content: new Text("Your account has been made please login"),
          backgroundColor: _theme.getCurrentColor(),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.popAndPushNamed(context, Start.id);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogFail(BuildContext context, e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var _theme = Provider.of<ThemeChanger>(context);

        return AlertDialog(
          title: new Text(
            "Registration is Failed",
            style: _theme
                .getThemeData()
                .textTheme
                .headline1
                .merge(TextStyle(color: _theme.getThemeData().hintColor)),
          ),
          content: new Text("$e"),
          backgroundColor: _theme.getCurrentColor(),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.popAndPushNamed(context, Start.id);
              },
            ),
          ],
        );
      },
    );
  }

  login(String email, String password, BuildContext context) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    await _auth.currentUser().then((user) async {
      var userData = await _fire.collection('users').document(user.uid).get();

      _user = User(id: userData.data['id']);

      setEmail(userData.data['email']);

      setName(userData.data['name']);

      setPic(userData.data['picUrl']);

      setPhone(userData.data['phone']);

      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
    });
  }
}
