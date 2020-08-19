import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/data.dart';
import './register_screen_components/register_home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green[800],
          accentColor: Colors.green,
//        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.purple)),
        ),
        home: RegisterScreen(),
      ),
    );
  }
}







