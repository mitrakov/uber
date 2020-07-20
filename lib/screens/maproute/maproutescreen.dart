import 'package:flutter/material.dart';
import 'package:uber/screens/maproute/widgets/maproutewidget.dart';
import 'package:uber/screens/maproute/widgets/request/requestwidget.dart';

class MapRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 295,
            child: Stack(
              children: <Widget>[
                MapRouteWidget(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, top: 20),
                    child: Builder(
                      builder: (context1) => makeIcon(Icons.android),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 342,
            child: RequestWidget(),
          ),
        ],
      ),
    );
  }

  Widget makeIcon(IconData icon) {
    return Material(
      color: Colors.lightBlue,
      shape: CircleBorder(),
      shadowColor: Colors.red,
      elevation: 20,
      child: Ink(
        decoration: const ShapeDecoration(
          color: Colors.lightBlue,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(icon),
          color: Colors.white,
          onPressed: () {print("opa");},
        ),
      ),
    );
  }
}
