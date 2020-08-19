import 'package:flutter/material.dart';
import 'package:whatsapptest/widgets/photo_status.dart';

class AddStatus extends StatelessWidget {
  final profilePhoto;

  AddStatus({this.profilePhoto,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: ProfilePhotoForStatus(profilePhoto: profilePhoto,),
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
                    'My Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tap to add status update',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}