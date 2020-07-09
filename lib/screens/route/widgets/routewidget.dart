import 'package:flutter/material.dart';
import 'package:uber/screens/route/widgets/addresseditor.dart';
import 'package:uber/screens/route/widgets/linepoints.dart';

class RouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        LinePoints(),
        Expanded(
          child: Column(
            children: <Widget>[
              AddressEditor("From"),
              AddressEditor("Where to?"),
            ],
          )
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Icon(Icons.add),
        )
      ],
    );
  }
}
