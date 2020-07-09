import 'package:flutter/material.dart';

class LinePoints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(Icons.brightness_1),
        SizedBox(width: 20, height: 20),
        Icon(Icons.stop),
      ],
    );
  }
}
