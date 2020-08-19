import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/home.dart';
import '../providers/data.dart';


class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  var data;

  String name;

  @override
  Widget build(BuildContext context) {
    data = Provider.of<Data>(context, listen: false);
    return
          Center(
        child: Column(
          children: <Widget>[
            Text('Profile info'),
            Text('Please provide your name and an optional profile photo'),
            CircleAvatar(
              child: Icon(Icons.add_a_photo),
              radius: 40,
            ),
            TextField(
              onChanged: (name) {
               data.onNameChanged(name);
              },
            ),
            RaisedButton(
              child: Text('Next'),
              onPressed: ()=>nextButton(context),
            )
          ],
        ),
//      ),
    );

  }

  void nextButton(BuildContext context)async{
 
    // data.saveName(name);
    data.setUpUser().whenComplete(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
      print('user setted up');
      // print('senderId is ${data.senderId}');
    },
    );
  }
}
