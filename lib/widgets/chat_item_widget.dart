import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat_item.dart';
import '../providers/data_base.dart';
import './profile_photo.dart';
import '../screens/conversation.dart';

class ChatItemWidget extends StatelessWidget {
  final ChatItem chatItem;
  ChatItemWidget(this.chatItem);

  @override
  Widget build(BuildContext context) {
    final dataBase = Provider.of<DataBase>(context,listen: false);
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                // print('senderName is ${myData.userName}');
                dataBase.changeCurrentChat(chatItem);
                return Conversation(
                  fromChatsScreen: true,
                );
              },
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          color: Colors.white60,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: userProfilePhoto(photoUrl: chatItem.profilePhoto),
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        chatItem.userName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${chatItem.lastMessage}',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        );
  }
}
