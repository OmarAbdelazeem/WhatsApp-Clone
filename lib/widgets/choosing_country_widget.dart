import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_data.dart';
import '../screens/countries_codes_screen.dart';

class ChoosingCountry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AuthData>(context, listen: true);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountriesCodesScreen(),
          ),
        );
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
                    Text(data.selectedCountry),
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
