import 'package:flutter/material.dart';

class LinePoints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(bottom: 2), child: Icon(Icons.brightness_1, size: 6, color: Colors.grey),),
        Container(color: Colors.grey, width: 1.5, height: 30),
        Icon(Icons.stop, size: 13),
      ],
    );
  }
}
