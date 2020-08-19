import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/data.dart';

class TextFields extends StatelessWidget {
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Consumer<Data>(builder: (context, countryData, child) {
            _controller =
                TextEditingController(text: countryData.selectedPhoneCode);
            print(countryData.selectedPhoneCode);
            return TextFormField(
              controller: _controller,
            );
          }),
          width: 60.0,
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          child: Consumer<Data>(
            builder: (context,countryData,child)=>
             TextField(
              decoration: InputDecoration(
                  hintText: 'phone number'
              ),
              onChanged: (phoneNumber){
                countryData.onPhoneChanged(phoneNumber);
              },
            ),
          ),
          width: 130.0,
        )
      ],
    );
  }
}
