import 'dart:io';

import 'package:flutter/material.dart';

// import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePhotoForStatus extends StatelessWidget {
  final File profilePhoto;

  ProfilePhotoForStatus({this.profilePhoto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 85,
        width: 85,
        child: Stack(
          children: <Widget>[
            Container(
              height: 90,
              width: 90,
              child: profilePhoto != null
                  ? CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xffFDCF09),
                      child: CircleAvatar(
                          radius: 50, backgroundImage: FileImage(profilePhoto)),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: Icon(
                        Icons.person_outline,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
            ),
            Positioned(
              child: Image.asset(
                'assets/images/add.png',
                height: 20,
                width: 20,
              ),
              // Image.asset('assets/images/add.png',fit: BoxFit.cover,height: 10,width: 10,),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      ),
    );
  }
}
