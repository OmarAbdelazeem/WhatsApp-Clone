import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contacts.dart';
import '../providers/data.dart';
import '../models/chat_item.dart';
import '../widgets/chat_item_widget.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserChats(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Contacts();
          },
          ),
          );
        },
      ),
    );
  }
}

class UserChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myData = Provider.of<Data>(context, listen: false);

    Stream<DocumentSnapshot> usersSnapShot = Firestore.instance
        .collection('users')
        .document(myData.senderId)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
        stream: usersSnapShot,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            // get usersSnapShot document
            List usersDocument = snapshot.data.data['userChats'];
        
              usersDocument.forEach((chat){
                print('chat is $chat');
              });

            // get sections from the document
            List<ChatItem> chats=[];
            
              usersDocument.forEach((chat){
                chats.add(ChatItem.fromJson(chat));
              });

            print('sections is $chats');
            // build list using names from sections
            return ListView.builder(
              itemCount: chats != null ? chats.length : 0,
              itemBuilder: (_, int index) {
                print(chats[index]);

                return ChatItemWidget(chats[index]);
              },
            );
          } else {
            return Container();
          }
        },
    );
  }
}
