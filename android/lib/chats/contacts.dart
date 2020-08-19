import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../widgets/contact_widget.dart';
import '../providers/data.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersStream = Firestore.instance.collection('users').snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select Contact',
              ),
              Text(
                'N contacts',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
        body: Consumer<Data>(
          builder: (context, countryData, child) => StreamBuilder(
            stream: usersStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                  User user = User.fromJson(snapshot.data.documents[index]);
                    if (user.myId != countryData.senderId)
                      return ContactWidget(
                     user: user,
                      );
                    else
                      return Container();
                  });
            },
          ),
        ),
    );
  }
}
