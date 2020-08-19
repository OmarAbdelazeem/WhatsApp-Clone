import 'package:flutter/material.dart';
import '../models/user.dart';
import './profile_photo.dart';
import '../chats/conversation.dart';

class ContactWidget extends StatelessWidget {
  final User user;

  ContactWidget({this.user});

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
                  receiverId: user.myId,
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
                        user.name,
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
    
    // GestureDetector(
    //   onTap: () async {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) {
    //             return Conversation(
    //               receiverId: user.myId,
    //             );
    //           },
    //         ),
    //       );
    //       return;
    //   },
    //   child: ListTile(
    //     leading: CircleAvatar(
    //       child: Icon(Icons.person),
    //     ),
    //     title: Text(user.name),
    //   ),
    // );
  }
}
