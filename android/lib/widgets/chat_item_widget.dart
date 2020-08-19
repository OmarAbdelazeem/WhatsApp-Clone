import 'package:flutter/material.dart';
import './profile_photo.dart';
import '../models/chat_item.dart';
import '../chats/conversation.dart';

class ChatItemWidget extends StatelessWidget {
  final ChatItem chatItem;
  ChatItemWidget(this.chatItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                // print('senderName is ${myData.userName}');

                return Conversation(
                  receiverId: chatItem.userId,
                );
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: userProfilePhoto(),
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
                        'last Message',
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
