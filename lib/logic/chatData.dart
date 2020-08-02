import 'package:chatchat/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatData extends ChangeNotifier {
  Firestore _fire = Firestore.instance;
  User _receiver; //the receiver who receive chat msg
  List<User> _receiversList = [];

  getReceiverName() => _receiver.getName();
  getReceiverId() => _receiver.id;
  getReceiverPic() => _receiver.getPic();
  getItemsCountFromListOfReceivers() => _receiversList.length;
  getListOfReceivers(int index) => _receiversList[index];

  //set receiver data to start chatting
  setReceiver(String token, String name, String pic) {
    _receiver = User(id: token);
    _receiver.setName(name);
    notifyListeners();
  }

  //This fill the receivers list to fill home screen with chats
  fillReceiversList(String currentUserToken) async {
    var messages = await _fire.collection("$currentUserToken").getDocuments();
    for (var message in messages.documents) {
      bool found = false;
      var currentReceiver = await _fire
          .collection("users")
          .document('${message.data['receiver'].toString()}')
          .get();
      for (var re in _receiversList) {
        if (re.id == message.data['receiver'].toString()) {
          found = true;
        }
      }
      if (!found) {
        var record = User(id: currentReceiver.data['id'].toString());
        record.setPic(currentReceiver.data['picUrl'].toString());
        record.setName(currentReceiver.data['name'].toString());
        _receiversList.add(record);
      }
    }
    notifyListeners();
  }

  //get the receiver data from the list for current chats
  getReceiverFromList(index) async {
    var userData = _receiversList[index];
    User receiverList = User(id: userData.id);
    receiverList.setPic(userData.getPic());
    receiverList.setName(userData.getName());
    return receiverList;
  }

  // send chat message to firebase to send it to the receiver
  sendChatMessage(
      String currentUserToken, String receiverUserToken, String message) {
    _fire
        .collection("chat-$currentUserToken-$receiverUserToken")
        .document("${DateTime.now().toIso8601String()}")
        .setData({
      'message': message,
      'sender': currentUserToken,
      'receiver': receiverUserToken,
      'datetime': DateTime.now().toIso8601String(),
    });
  }
}
