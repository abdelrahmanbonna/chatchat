import 'package:chatchat/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatData extends ChangeNotifier {
  Firestore _fire = Firestore.instance;
  User _receiver; //the receiver who receive chat msg

  getReceiverName() => _receiver.getName();
  getReceiverId() => _receiver.id;
  getReceiverPic() => _receiver.getPic();

  //set receiver data to start chatting
  setReceiver(String token, String name, String pic) {
    _receiver = User(id: token);
    _receiver.setName(name);
    notifyListeners();
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
