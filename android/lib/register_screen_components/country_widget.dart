import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/data.dart';
import 'countries_codes_screen.dart';

class CountryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CountriesCodes()));
      },
      child: Container(
        width: 200,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Consumer<Data>(
                      builder: (context, countryData, child) =>
                          Text(countryData.selectedCountry),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.green[900],
                    )
                  ],
                ),
              ],
            ),
            Divider(
              height: 10,
              color: Colors.green[900],
            )
          ],
        ),
      ),
    );
  }
}