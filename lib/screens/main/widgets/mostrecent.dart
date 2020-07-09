import 'package:flutter/material.dart';
import 'package:uber/screens/main/widgets/mostrecentitem.dart';

class MostRecent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        MostRecentItem(),
        MostRecentItem(),
        MostRecentItem(),
      ],
    );
  }
}
