import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_data.dart';

class CountryWithItsCode extends StatelessWidget {
  final name;
  final phoneCode;
  final flag;

  CountryWithItsCode({this.name, this.phoneCode, this.flag});

  @override
  Widget build(BuildContext context) {
    final countryData = Provider.of<AuthData>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        countryData.onCountrySelected(name, phoneCode);
      },
      child: ListTile(
        leading: flag,
        title: Text(name),
        trailing: Text('+$phoneCode'),
      ),
    );
  }
}
