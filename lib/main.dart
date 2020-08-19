import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth_data.dart';
import './providers/data_base.dart';
import './screens/register_home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthData>(
          create: (context) => AuthData(),
        ),
        ChangeNotifierProvider<DataBase>(
          create: (context) => DataBase(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          buttonColor: Color(0xff00cb3d),
        ),
        home: RegisterScreen(),
      ),
    );
  }
}
