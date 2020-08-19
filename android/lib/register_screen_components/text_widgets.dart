import 'package:flutter/material.dart';

class TextWidgets extends StatelessWidget {
  final bigTitle;
  final smallTitle;
  final part1;
  final part2;
  TextWidgets({this.bigTitle,this.smallTitle,this.part1,this.part2});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            bigTitle,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            smallTitle,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(part1, style: TextStyle(fontSize: 15)),
                Text(
                  part2,
                  style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}