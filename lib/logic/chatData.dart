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
  sendChatMessage(currentUserToken, String message) async {
//    if (await _fire
//            .collection("chat")
//            .document("$currentUserToken-$receiverUserToken")
//            .get() ==
//        null) {
//      if (await _fire
//              .collection("chat")
//              .document("$receiverUserToken-$currentUserToken")
//              .get() ==
//          null) {
//        _fire
//            .collection("chat")
//            .document("$currentUserToken-$receiverUserToken")
//            .setData({
//          'messages': [
//            {
//              "message": message,
//              'datetime': DateTime.now().toIso8601String(),
//              'sender': currentUserToken,
//            }
//          ],
//          'sender': currentUserToken,
//          'receiver': receiverUserToken,
//        });
//      } else {
//        var oldData = await _fire
//            .collection("chat")
//            .document("$receiverUserToken-$currentUserToken")
//            .get();
//        List list1 = oldData.data['messages'];
//        List list2 = [
//          {
//            "message": message,
//            'datetime': DateTime.now().toIso8601String(),
//            'sender': currentUserToken,
//          }
//        ];
//
//        var newList = [...list1, ...list2].toSet().toList();
//        _fire
//            .collection("chat")
//            .document("$receiverUserToken-$currentUserToken")
//            .updateData({
//          'messages': newList,
//        });
//      }
//    } else {
//      var oldData = await _fire
//          .collection("chat")
//          .document("$currentUserToken-$receiverUserToken")
//          .get();
//
//      List list1 = oldData.data['messages'];
//      List list2 = [
//        {
//          "message": message,
//          'datetime': DateTime.now().toIso8601String(),
//          'sender': currentUserToken,
//        }
//      ];
//
//      var newList = [...list1, ...list2].toSet().toList();
//
//      _fire
//          .collection("chat")
//          .document("$currentUserToken-$receiverUserToken")
//          .updateData({
//        'messages': newList,
//      });
//    }
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
