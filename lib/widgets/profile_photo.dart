import 'package:flutter/material.dart';

Widget userProfilePhoto({String photoUrl}) {
  return photoUrl != null
      ? Container(
          height: 85,
          width: 85,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xffFDCF09),
            child: CircleAvatar(
                radius: 50, backgroundImage: NetworkImage(photoUrl),
                ),
          ),
        )
      : Container(
          height: 85,
          width: 85,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black26,
            child: Icon(
              Icons.person_outline,
              size: 40,
              color: Colors.white,
            ),
          ),
        );
}