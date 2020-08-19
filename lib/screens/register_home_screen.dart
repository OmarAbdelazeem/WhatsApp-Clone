import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_data.dart';
import 'package:whatsapptest/screens/ensure_number_dialog.dart';
import '../widgets/column_text_widgets.dart';
import '../widgets/choosing_country_widget.dart';
import '../screens/profile_info.dart';
import 'verifying_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String bigTitle = 'Enter your phone number';
  String smallTitle = 'WhatsApp will send an SMS message to verify your';
  String part1 = 'phone number.';
  String part2 = 'Whats\'s my number ?';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AuthData>(context, listen: true);
    var _countryCodeController =
        TextEditingController(text: data.selectedPhoneCode);
    return Scaffold(
      body: !data.isVerified
          ? SafeArea(
              child: !data.codeSent
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ColumnTextWidgets(
                              bigTitle: bigTitle,
                              smallTitle: smallTitle,
                              part1: part1,
                              part2: part2,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ChoosingCountry(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                      ),
                                      controller: _countryCodeController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: 130.0,
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          hintText: 'phone number'),
                                    onChanged: (phoneNumber) {
                                      data.onPhoneChanged(phoneNumber);
                                    },
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Carrier SMS changes may apply',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 17),
                            )
                          ],
                        ),
                        RaisedButton(
                          child: Text(
                            'NEXT',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => _nextButton(context),
                        ),
                      ],
                    )
                  : VerifyScreen(),
            )
          : SafeArea(
              child: ProfileInfo(),
            ),
    );
  }
  void _nextButton(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // user must tap button!
      builder: (BuildContext context) {
        return EnsureNumberDialog();
      },
    );
  }
}


