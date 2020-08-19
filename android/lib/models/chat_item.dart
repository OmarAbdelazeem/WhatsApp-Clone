class ChatItem{
String chatId;
String userId;
String userName;
// Map<String ,dynamic>
ChatItem.fromJson( var json){
  chatId = json['chatId'];
  userId = json['userId'];
  userName = json['userName'];
}
}