import 'package:flutter/material.dart';

class CallsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.width * 0.4,
//          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    'To start calling contacts who have',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Row(
                  children: <Widget>[
                    Text(
                      'WhatsApp, tap ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    Icon(
                      Icons.add_call,
                      color: Colors.black54,
                    ),
                    Text(' at the bottom of your',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'screen',
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff18DC22),
          onPressed: () {},
          child: Icon(
            Icons.add_call,
            color: Colors.white,
          )),
    );
  }
}
