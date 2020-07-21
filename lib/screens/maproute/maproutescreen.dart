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
                    padding: EdgeInsets.only(left: 7, top: 23),
                    child: Builder(
                      builder: (context1) => makeIcon(context, Icons.arrow_back),
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

  Widget makeIcon(BuildContext context, IconData icon) {
    return Material(
      color: Colors.lightBlue,
      shape: CircleBorder(),
      shadowColor: Colors.black,
      elevation: 20,
      child: Ink(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(icon),
          color: Colors.black,
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName("/main")),
        ),
      ),
    );
  }
}
