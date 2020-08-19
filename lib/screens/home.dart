import 'package:flutter/material.dart';
import 'package:whatsapptest/screens/status_screen.dart';
import '../screens/chats_screen.dart';

import 'calls.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List <Widget> tabViewChildren = [
      ChatsScreen(),
      StatusScreen(),
      CallsScreen()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff065d52),
        title: Text('WhatsApp'),
        actions: <Widget>[
          Icon(Icons.search),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.more_vert)
        ],
        bottom: TabBar(
          tabs: <Widget>[
            Padding(
              child: Text('CHATS'),
              padding: EdgeInsets.all(10),
            ),
            Padding(
              child: Text('STATUS'),
              padding: EdgeInsets.all(10),
            ),
            Padding(
              child: Text('CALLS'),
              padding: EdgeInsets.all(10),
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:tabViewChildren,
      ),
    );
  }
}
