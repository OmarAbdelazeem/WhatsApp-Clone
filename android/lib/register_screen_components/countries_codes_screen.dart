import 'package:country_pickers/countries.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/data.dart';

class CountriesCodes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: Colors.green[800]),
        iconTheme: IconThemeData(color: Colors.green[800]),
        backgroundColor: Colors.white,
        title: Text(
          'Choose a country',
          style: TextStyle(color: Colors.green[800]),
        ),
        actions: <Widget>[Icon(Icons.search)],
      ),
      body: ListView(
        children: countryList
            .map((country) => CodesWidget(
                  phoneCode: country.phoneCode,
                  name: country.name,
                  flag: CountryPickerUtils.getDefaultFlagImage(country),
                ))
            .toList(),
      ),
    );
  }
}

class CodesWidget extends StatelessWidget {
  final name;
  final phoneCode;
  final flag;

  CodesWidget({this.name, this.phoneCode, this.flag});

  @override
  Widget build(BuildContext context) {
    final countryData = Provider.of<Data>(context, listen: false);
    return  GestureDetector(
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
