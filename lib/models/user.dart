class User {
  final String id;
  User({this.id});
  String _name;
  String _phone;
  String _pic;
  String _lastmode;

  String getName() => _name;
  String getPhone() => _phone;
  String getPic() => _pic;
  String getLastMode() => _lastmode;

  setName(String name) {
    _name = name;
  }

  setPhone(String phone) {
    _phone = phone;
  }

  setPic(String pic) {
    _pic = pic;
  }

  setLastMode(String mode) {
    _lastmode = mode;
  }
}
