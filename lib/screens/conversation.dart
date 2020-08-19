import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/data_base.dart';
import '../models/chat_item.dart';
import '../models/user.dart';
import '../widgets/message_widget.dart';
import '../widgets/profile_photo.dart';

class Conversation extends StatefulWidget {
  final fromChatsScreen;

  Conversation({this.fromChatsScreen});

  @override
  _ConversationState createState() => _ConversationState();
}

Firestore fireStore = Firestore.instance;

class _ConversationState extends State<Conversation> {
  bool userFounded = false;
  bool loaded = false;
  var dataBase;
  bool isFirstMessage = false;

  ChatItem currentChat = ChatItem();
  User currentUser = User();
  User defaultUser = User();

  TextEditingController sendController = TextEditingController();

  final DateTime timestamp = DateTime.now();

  @override
  void initState() {
    dataBase = Provider.of<DataBase>(context, listen: false);
    defaultUser = dataBase.defaultUser;
    if (!widget.fromChatsScreen) {
      currentUser = dataBase.currentUser;
      List<ChatItem> defaultUserChats = dataBase.defaultUser.userChats;
      for (int i = 0; i < defaultUserChats.length; i++) {
        if (defaultUserChats[i].userId == currentUser.id) {
          userFounded = true;
          currentChat = defaultUserChats[i];
        }
      }
      if (!userFounded) {
        currentChat = ChatItem(
            userName: currentUser.name,
            chatId: Uuid().v4(),
            userId: currentUser.id,
            profilePhoto: currentUser.photoUrl);
        isFirstMessage = true;
      }
      setState(() {
        loaded = true;
      });
    } else {
      currentChat = dataBase.currentChat;
      setState(() {
        loaded = true;
      });
    }

    super.initState();
  }

  void send() async {
    if (sendController.text != null && sendController.text.length != 0) {
      // the begin of snippet for sending message to fireStore
      DocumentReference chatReference = Firestore.instance
          .collection('usersMessages')
          .document(currentChat.chatId)
          .collection('messages')
          .document();

      Map<String, dynamic> sentMessage = {
        'messageText': sendController.text,
        'senderId': defaultUser.id,
        'messageTime': timestamp
      };

      await chatReference.setData(sentMessage);
      // the end of snippet

      if (!userFounded && !widget.fromChatsScreen && isFirstMessage) {
        DocumentReference currentUserReference =
            Firestore.instance.collection('users').document(currentUser.id);
//      DocumentSnapshot docCurrentUser = await currentUserReference.get();

        DocumentReference defaultUserReference =
            Firestore.instance.collection('users').document(defaultUser.id);
        currentChat.lastMessage = sendController.text;

        currentUserReference.updateData({
          'userChats': FieldValue.arrayUnion([
            {
              'chatId': currentChat.chatId,
              'userId': defaultUser.id,
              'userName': defaultUser.name,
              'lastMessage': sendController.text,
              'profilePhoto': defaultUser.photoUrl
            }
          ])
        });

        defaultUserReference.updateData({
          'userChats': FieldValue.arrayUnion([
            {
              'chatId': currentChat.chatId,
              'userId': currentUser.id,
              'userName': currentUser.name,
              'lastMessage': sendController.text,
              'profilePhoto': currentChat.profilePhoto
            }
          ])
        });
        isFirstMessage = false;
      }
      sendController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              backgroundColor: Color(0xff065d52),
              actions: <Widget>[
                Icon(Icons.videocam),
                SizedBox(
                  width: 13,
                ),
                Icon(Icons.call),
                SizedBox(
                  width: 13,
                ),
                Icon(Icons.more_vert),
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 38,
                    width: 38,
                    child: userProfilePhoto(photoUrl: currentChat.profilePhoto),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    currentChat.userName,
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: fireStore
                      .collection('usersMessages')
                      .document(currentChat.chatId)
                      .collection('messages')
                      .orderBy('messageTime', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    snapshot.data.documents.forEach((element) {
                      print('message is ${element['messageText']}');
                    });
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return MessageWidget(
                            text: snapshot.data.documents[index]['messageText'],
                            isMe: snapshot.data.documents[index]['senderId'] ==
                                defaultUser.id,
                            time: snapshot.data.documents[index]['messageTime'],
                          );
                        },
                        itemCount: snapshot.data.documents.length,
                      ),
                    );
                  },
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 50,
                          child: TextField(
                            controller: sendController,
                            autocorrect: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.insert_emoticon),
                              suffixIcon: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(Icons.attach_file),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.camera_alt),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Type a message',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FloatingActionButton(
                        backgroundColor: Color(0xff065d52),
                        onPressed: send,
                        child: Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
