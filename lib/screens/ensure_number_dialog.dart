import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_data.dart';

class EnsureNumberDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthData>(
      builder: (context ,data ,child){
        return AlertDialog(
//           title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('We will be verifying the phone number:',style: TextStyle(fontSize: 16)),
                SizedBox(height: 15,),
                Text('+${data.selectedPhoneCode + data.phoneNumber}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                Text('Is this Ok, or you would like to edit the number?',),

              ],
            ),
          ),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FlatButton(
                      child: Text('Edit',style: TextStyle(color: Color(0xff007f5f) ),),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: FlatButton(
                      child: Text('Ok',style: TextStyle(color: Color(0xff007f5f) ),),
                      onPressed: () async{
                        Navigator.of(context).pop();
                        await data.verifyPhone();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },

    );
  }
}

