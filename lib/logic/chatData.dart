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
    _receiver.setPic(pic);
    notifyListeners();
  }

  // send chat message to firebase to send it to the receiver
  sendChatMessage(currentUserToken, String message) async {
    bool done = false;
    await _fire
        .collection('chat')
        .document("$currentUserToken-${_receiver.id}")
        .get()
        .then((value) {
      if (value.exists) {
        _fire
            .collection('chat')
            .document("$currentUserToken-${_receiver.id}")
            .updateData({
          'messages': value.data['messages'] +
              [
                {
                  "message": message,
                  'datetime': DateTime.now().toIso8601String(),
                  'sender': currentUserToken,
                }
              ]
        });
        done = true;
      }
    });
    await _fire
        .collection('chat')
        .document("${_receiver.id}-$currentUserToken")
        .get()
        .then((value) {
      if (value.exists) {
        _fire
            .collection('chat')
            .document("${_receiver.id}-$currentUserToken")
            .updateData({
          'messages': value.data['messages'] +
              [
                {
                  "message": message,
                  'datetime': DateTime.now().toIso8601String(),
                  'sender': currentUserToken,
                }
              ]
        });
        done = true;
      }
    });
    if (!done)
      _fire
          .collection("chat")
          .document("$currentUserToken-${_receiver.id}")
          .setData({
        'messages': [
          {
            "message": message,
            'datetime': DateTime.now().toIso8601String(),
            'sender': currentUserToken,
          }
        ],
        'sender': currentUserToken,
        'receiver': _receiver.id,
      });
  }
}
