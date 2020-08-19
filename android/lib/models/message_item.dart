import 'package:cloud_firestore/cloud_firestore.dart';

class MessageItem{
  String messageText;
  Timestamp messageTime;
  String senderId;

  MessageItem.fromJson(var snapshot){
      messageText = snapshot['messageText'];
      messageTime = snapshot['messageTime'];
      senderId = snapshot['senderId'];
  }
}