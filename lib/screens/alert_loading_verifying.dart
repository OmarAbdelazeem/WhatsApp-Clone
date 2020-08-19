import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_data.dart';

class AlertLoadingVerifying extends StatefulWidget {
  final String smsCode;

  AlertLoadingVerifying(this.smsCode);

  @override
  _AlertLoadingVerifyingState createState() => _AlertLoadingVerifyingState();
}

class _AlertLoadingVerifyingState extends State<AlertLoadingVerifying> {
  var myData;
  bool loading = true;
  bool isCorrectCode = true;
  @override
  void initState() {
    super.initState();
    myData = Provider.of<AuthData>(context, listen: false);
    myData.signWithOtp(widget.smsCode).then((value) {
      if (value != null) {
        Navigator.pop(context);
      } else {
        setState(() {
          loading = false;
          isCorrectCode = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
//           title: Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: (loading && isCorrectCode)
            ? Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 20,
            ),
            Text('Verifying'),
          ],
        )
            : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('The code you entered is incorrect'),
              SizedBox(
                width: 20,
              ),
              Text('Please try again'),
            ]),
      ),
      actions: <Widget>[
        (!loading && !isCorrectCode)
            ? FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Ok',
            style: TextStyle(color: Color(0xff007f5f)),
          ),
        )
            : Container()
      ],
    );
  }
}
