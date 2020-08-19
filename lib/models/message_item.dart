import 'package:cloud_firestore/cloud_firestore.dart';

class MessageItem{
  String messageText;
  var messageTime;
  String senderId;

  MessageItem.fromJson(var snapshot){
      messageText = snapshot['messageText'];
      messageTime = snapshot['messageTime'];
      senderId = snapshot['senderId'];
  }
}