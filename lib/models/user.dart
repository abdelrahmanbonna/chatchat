class User {
  final String id;
  User({this.id});
  String _name;
  String _phone;
  String _pic, _email;

  String getName() => _name;
  String getPhone() => _phone;
  String getPic() => _pic;
  String getEmail() => _email;

  setName(String name) {
    _name = name;
  }

  setPhone(String phone) {
    _phone = phone;
  }

  setPic(String pic) {
    _pic = pic;
  }

  setEmail(String email) {
    _email = email;
  }
}
