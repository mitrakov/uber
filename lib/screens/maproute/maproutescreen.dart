import 'package:flutter/material.dart';
import 'package:uber/screens/main/widgets/maindrawer.dart';
import 'package:uber/screens/maproute/widgets/maproutewidget.dart';

class MapRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: Stack(
        children: <Widget>[
          MapRouteWidget(),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5, top: 20),
              child: Builder(
                builder: (context1) => IconButton(
                  icon: Icon(Icons.arrow_back, size: 28),
                  onPressed: () => Navigator.popUntil(context, ModalRoute.withName("/main")),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
