import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import '../providers/auth_data.dart';
import '../widgets/column_text_widgets.dart';
import '../screens/alert_loading_verifying.dart';

class VerifyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AuthData>(context, listen: false);
    String bigTitle =
        'Verify +${data.selectedPhoneCode + data.phoneNumber}';
    String smallTitle = 'Waiting to automaticly detect an SMS sent to';
    String part1 = '+${data.selectedPhoneCode + data.phoneNumber}';
    String part2 = 'Wrong number ?';

    void onVerificationCodeComplete(String smsCode) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertLoadingVerifying(smsCode);
        },
      );
    }

    return Column(
          children: <Widget>[
            ColumnTextWidgets(
              bigTitle: bigTitle,
              smallTitle: smallTitle,
              part1: part1,
              part2: part2,
            ),
            Container(
              child: OTPTextField(
                length: 6,
                fieldWidth: 30,
                style: TextStyle(fontSize: 14),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: onVerificationCodeComplete,
              ),
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Enter 6-digit code')
          ],
        );


  }
}
