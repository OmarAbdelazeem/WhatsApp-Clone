import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat_item.dart';
import '../providers/data_base.dart';
import 'contacts.dart';
import '../widgets/chat_item_widget.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataBase = Provider.of<DataBase>(context, listen: false);

    Stream<DocumentSnapshot> usersSnapShot = Firestore.instance
        .collection('users')
        .document(dataBase.defaultUser.id)
        .snapshots();

    var emptyChatsSize = MediaQuery.of(context).size.height * 0.7;
    var chatsSize = MediaQuery.of(context).size.height * 0.83;
    bool hasChats = false;

    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      body: StreamBuilder<DocumentSnapshot>(
        stream: usersSnapShot,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            // get usersSnapShot document
            List usersDocument = [];
            usersDocument = snapshot.data['userChats'];

            // get sections from the document
            List<ChatItem> chats = [];
            usersDocument.forEach((chat) {
              chats.add(ChatItem.fromJson(chat));
            });
            dataBase.defaultUser.userChats = chats;

            if (chats.length > 0) hasChats = true;
            print('sections is $chats');
            print('chats.length is ${chats.length}');
            print('usersDocument.length is ${usersDocument.length}');
            // build list using names from sections
            return Column(
              children: <Widget>[
                Container(
                  height: hasChats ? chatsSize : emptyChatsSize,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: chats != null ? chats.length : 0,
                    itemBuilder: (_, int index) {
                      print(chats[index]);

                      return ChatItemWidget(chats[index]);
                    },
                  ),
                ),
                hasChats
                    ? Expanded(
                        child: Container(
                        height: 100,
                        color: Colors.white,
                      ),
                )
                    : Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Start a chat',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff065d52),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.arrow_forward,
                                        color: Color(0xff065d52)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff18DC22),
        child: Icon(
          Icons.message,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Contacts();
              },
            ),
          );
        },
      ),
    );
  }
}
