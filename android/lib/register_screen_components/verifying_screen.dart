import 'package:flutter/material.dart';
import './text_fields.dart';
import './verifying_screen.dart';
import './profile_info.dart';
import '../register_screen_components/text_widgets.dart';
import '../providers/data.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    final myData = Provider.of<Data>(context, listen: false);
    String bigTitle =
        'Verify +${myData.selectedPhoneCode + myData.phoneNumber}';
    String smallTitle = 'Waiting to automaticly detect an SMS sent to';
    String part1 = '+${myData.selectedPhoneCode + myData.phoneNumber}';
    String part2 = 'Wrong number ?';

    return Column(
      children: <Widget>[
        TextWidgets(
          bigTitle: bigTitle,
          smallTitle: smallTitle,
          part1: part1,
          part2: part2,
        ),
        Container(
          child: Consumer<Data>(
            builder: (context, countryData, child) => TextField(
              decoration: InputDecoration(hintText: 'phone number'),
              onChanged: (String smsCode) {
                if (smsCode.length == 6) {
                  countryData.signWithOtp(smsCode);
                }
              },
            ),
          ),
          width: 130.0,
        ),
        Text('Enter 6-digit code')
      ],
    );
  }
}
