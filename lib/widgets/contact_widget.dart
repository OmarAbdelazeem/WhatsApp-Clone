import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/conversation.dart';
import '../models/user.dart';
import '../providers/data_base.dart';
import './profile_photo.dart';

class ContactWidget extends StatelessWidget {
  final User user;

  ContactWidget({this.user});

  @override
  Widget build(BuildContext context) {
    final dataBase = Provider.of<DataBase>(context,listen: false);
    return GestureDetector(
        onTap: () {
          print(user.photoUrl);
          dataBase.changeCurrentUser(user);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                // print('senderName is ${myData.userName}');
                return Conversation(
                  fromChatsScreen: false,
                );
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                child: userProfilePhoto(photoUrl: user.photoUrl),
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                user.name,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
              ),
            ],
          ),
        ),
        );
  }
}
