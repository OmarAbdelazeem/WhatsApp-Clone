import './chat_item.dart';
class User {
  String myId;
  String name;
  String photoUrl;
  String status;
  List<ChatItem> userChats = [];

  User.fromJson(var snapshot) {
    myId = snapshot['myId'];
    name = snapshot['name'];
    status = snapshot['status'];
    photoUrl = snapshot['photoUrl'];
    snapshot['userChats'].forEach(
      (chat) => userChats.add(
        ChatItem.fromJson(chat),
      ),
    );
  }
}
