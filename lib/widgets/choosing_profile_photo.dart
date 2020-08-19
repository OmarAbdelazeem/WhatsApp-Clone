import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/data_base.dart';

class ChoosingProfilePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataBase = Provider.of<DataBase>(context, listen: false);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom:
            MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height:
          MediaQuery.of(context).size.height * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'Profile photo',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                width: double.infinity,
                padding:
                EdgeInsets.only(left: 20, top: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.photo,
                              size: 35,
                            ),
                            onPressed: () {
                              dataBase.handleImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                          ),
                          Text('Gallery'),
                        ],
                      ),
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.photo_camera,
                              size: 35,
                            ),
                            onPressed: () {
                              dataBase.handleImage(
                                  ImageSource.camera);
                              Navigator.pop(context);
                            },
                          ),
                          Text('Camera')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
