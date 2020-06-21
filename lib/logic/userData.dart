import 'package:chatchat/models/user.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  User _user;

  UserData() {
    _user = User(id: "1");
  }

  String getName() => _user.getName();
  String getPhone() => _user.getPhone();
  String getPic() => _user.getPic();
  bool getLastMode() => _user.getLastMode();
}
