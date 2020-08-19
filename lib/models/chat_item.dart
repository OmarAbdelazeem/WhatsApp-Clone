class ChatItem{
String chatId;
String userId;
String userName;
String lastMessage;
String profilePhoto;
// Map<String ,dynamic>
  ChatItem({this.chatId,this.lastMessage,this.userName,this.userId,this.profilePhoto});

ChatItem.fromJson( var json){
  chatId = json['chatId'];
  userId = json['userId'];
  userName = json['userName'];
  lastMessage = json['lastMessage'];
  profilePhoto = json['profilePhoto'];
}
}