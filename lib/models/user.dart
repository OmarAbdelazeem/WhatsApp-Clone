import 'package:whatsapptest/models/chat_item.dart';

class User {
  String id;
  String name;
  String photoUrl;
  String status;
  List<ChatItem> userChats = [];

  User({this.photoUrl,this.name,this.id,this.status,this.userChats});

  User.fromJson(var snapshot) {
    id = snapshot['myId'];
    name = snapshot['name'];
    status = snapshot['status'];
    photoUrl = snapshot['profilePhoto'];
    snapshot['userChats'].forEach(
      (chat) => userChats.add(
        ChatItem.fromJson(chat),
      ),
    );
  }
}
