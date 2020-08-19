import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'country_widget.dart';
import './text_fields.dart';
import './verifying_screen.dart';
import './profile_info.dart';
import './text_widgets.dart';
import '../providers/data.dart';



class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String phoneNo, smsCode;

//  bool codeSent = false;
  String bigTitle = 'Enter your phone number';
  String smallTitle = 'WhatsApp will send an SMS message to verify your';
  String part1 = 'phone number.';
  String part2 = 'Whats\'s my number ?';

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, countryData, child) => Scaffold(
        body: !countryData.isVerified
            ? SafeArea(
                child: !countryData.codeSent
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextWidgets(
                                bigTitle: bigTitle,
                                smallTitle: smallTitle,
                                part1: part1,
                                part2: part2,
                              ),
                              CountryWidget(),
                              TextFields(),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Carrier SMS changes may apply')
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Consumer<Data>(
                              builder: (context, country, child) =>
                                  RaisedButton(
                                color: Colors.lightGreen[600],
                                child: Text('NEXT'),
                                onPressed: () async {
                                  await countryData.verifyPhone();
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : VerifyScreen(),
              )
            : SafeArea(
                child: ProfileInfo(),
              ),
      ),
    );
  }
}
