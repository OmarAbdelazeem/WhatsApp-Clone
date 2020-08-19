import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_data.dart';
import '../providers/data_base.dart';
import 'home.dart';
import '../widgets/choosing_profile_photo.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  TextEditingController nameController = TextEditingController();
  var dataBase;
  var authData;
  @override
  Widget build(BuildContext context) {
    dataBase = Provider.of<DataBase>(context, listen: true);
    authData = Provider.of<AuthData>(context,listen: false);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Profile info',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff299185),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Please provide your name and an optional profile photo',
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: onPhotoTapped,
                  child: dataBase.profilePhotoFile == null
                      ? CircleAvatar(
                          backgroundColor: Color(0xffdcdedf),
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.grey,
                            size: 38,
                          ),
                          radius: 50,
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xffFDCF09),
                          child: CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(dataBase.profilePhotoFile)),
                        ),
                ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: TextFormField(
                        controller: nameController,
                        onChanged: (name) {
                          dataBase.onNameChanged(name);
                        },
                        decoration:
                        InputDecoration(hintText: 'Type your name here'),
                      ),
                    ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                color: Color(0xff00cb3d),
                child: Text(
                  'NEXT',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => nextButton(context),
              ),
            )
          ],
        ),
      ),
      ),
    );
  }

  void nextButton(BuildContext context) async {
    if(nameController.text != null && nameController.text.length != 0){
      dataBase.setUpUser(phoneNumber :authData.phoneNumber , userId: authData.userId).whenComplete(
            () {
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

  void onPhotoTapped() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => ChoosingProfilePhoto(),
    );
  }

}
