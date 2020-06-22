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

  UserData() {
    _user = User(id: "1");
    setName("Abdelrahman Bonna");
    setPhone("+201102777726");
    setPic(
        "https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/p960x960/67905530_2563448493679142_8641091737009258496_o.jpg?_nc_cat=110&_nc_sid=7aed08&_nc_eui2=AeEggl8YnRVcTab5VgZXWD8ojl-CSaBPdE2OX4JJoE90TfNRrPdqqM4lHnVXblsmcDf1yjbTEIvefZmOJvGyoOu8&_nc_ohc=NXbku4VLDzIAX-QbMJ-&_nc_ht=scontent-hbe1-1.xx&_nc_tp=6&oh=cd837684fed4255144fa4821bb03cec5&oe=5F15E16C");
  }

  String getName() => _user.getName();
  String getPhone() => _user.getPhone();
  String getPic() => _user.getPic();
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

  void _showDialogFail(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var _theme = Provider.of<ThemeChanger>(context);

        return AlertDialog(
          title: new Text(
            "Registration is failed",
            style: _theme
                .getThemeData()
                .textTheme
                .headline1
                .merge(TextStyle(color: _theme.getThemeData().hintColor)),
          ),
          content: new Text("$msg\nPlease Try again later"),
          backgroundColor: _theme.getCurrentColor(),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> registerUser(
      BuildContext context, String name, String phone, File pic) async {
    String verificationId, smsCode;

    final PhoneVerificationFailed verifyFail = (AuthException exception) {
      _showDialogFail(context, exception.message.toString());
    };

    final PhoneCodeSent smsCodeSent = (verId, [int forceResendToken]) {
      //Todo what is done in the process of verifying the number
      smsCode = _getVerifyCode(context);
      verificationId = verId;
    };

    final PhoneVerificationCompleted verifySuccess =
        (AuthCredential authCredential) {
      //Todo here is what done after phone is verified
      _auth.signInWithCredential(authCredential).then((AuthResult result) {
        print("Done User is Verified.");

        _showDialog(context);
      });
    };

    final PhoneCodeAutoRetrievalTimeout timeout = (verId) {
      verificationId = verId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: verifySuccess,
        verificationFailed: verifyFail,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: timeout);
  }

  String _getVerifyCode(BuildContext context) {
    String input = "";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var _theme = Provider.of<ThemeChanger>(context);
        return AlertDialog(
          title: new Text(
            "Enter the sms code",
            style: _theme
                .getThemeData()
                .textTheme
                .headline1
                .merge(TextStyle(color: _theme.getThemeData().hintColor)),
          ),
          content: new TextField(
            onChanged: (value) {
              input = value;
            },
          ),
          backgroundColor: _theme.getCurrentColor(),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Done"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );

    return input;
  }

  void signIn(String phone, BuildContext context) async {
    String verificationId, smsCode;

    final PhoneVerificationFailed verifyFail = (AuthException exception) {
      _showDialogFail(context, exception.message.toString());
    };

    final PhoneCodeSent smsCodeSent = (verId, [int forceResendToken]) {
      //Todo what is done in the proccess of verifing the number
      smsCode = _getVerifyCode(context);
      verificationId = verId;
    };

    final PhoneVerificationCompleted verifySuccess =
        (AuthCredential authCredential) {
      //Todo here is what done after phone is verified
      _auth.signInWithCredential(authCredential).then((AuthResult result) {
        print("Done User is Verified.");
        _user = User(id: result.user.uid);
        setName(result.user.displayName);
        setPic(result.user.photoUrl);
        setPhone(result.user.phoneNumber);
        Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
      }); //Do the sign in ops
    };

    final PhoneCodeAutoRetrievalTimeout timeout = (verId) {
      verificationId = verId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: verifySuccess,
        verificationFailed: verifyFail,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: timeout);
  }

  void signOut() {
    _auth.signOut();
    _user = User(id: "");
    setName("");
    setPic("");
    setPhone("");
    notifyListeners();
  }
}
