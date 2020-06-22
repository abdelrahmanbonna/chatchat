import 'package:chatchat/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  User _user;
  FirebaseAuth _auth = FirebaseAuth.instance;

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
}
