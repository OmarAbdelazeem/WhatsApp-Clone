import 'package:country_pickers/countries.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import '../widgets/country_with_code.dart';

class CountriesCodesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff065d52)),
        backgroundColor: Colors.white,
        title: Text(
          'Choose a country',
          style: TextStyle(color: Color(0xff065d52)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,color: Color(0xff065d52),),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: countryList
            .map((country) => CountryWithItsCode(
                  phoneCode: country.phoneCode,
                  name: country.name,
                  flag: CountryPickerUtils.getDefaultFlagImage(country),
                ))
            .toList(),
      ),
    );
  }
}


