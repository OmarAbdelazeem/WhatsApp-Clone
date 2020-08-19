import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapptest/providers/data_base.dart';
import 'package:whatsapptest/widgets/my_status_widget.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataBase = Provider.of<DataBase>(context, listen: false);
    return Scaffold(
      body: Column(
        children: <Widget>[
          AddStatus(profilePhoto: dataBase.profilePhotoFile,),
          Stack(
            children: <Widget>[
              Container(
//                alignment: Alignment.topCenter,
                child: Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: Colors.black87,
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                color: Colors.black12,
                child: Center(
                    child: Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Recent Updates',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 16),
                  ),
                  width: double.infinity,
                )),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 130,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white60,
//              decoration: Dex ,
              height: 50,
              width: 50,
              child: FloatingActionButton(
                foregroundColor: Colors.white60,
                focusColor: Colors.white60,
                hoverColor: Colors.white60,
                splashColor: Colors.white60,
                onPressed: (){},
                backgroundColor: Colors.white60,
                child: Icon(Icons.edit,color: Colors.blueGrey,),
              ),
            ),
            SizedBox(height: 15,),
            FloatingActionButton(
              backgroundColor: Color(0xff18DC22),
              onPressed: (){},
              child: Icon(Icons.camera_alt),
            ),
          ],
        ),
      ),
    );
  }
}
