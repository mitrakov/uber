import 'package:flutter/material.dart';
import 'package:uber/screens/route/widgets/recentaddresses.dart';
import 'package:uber/screens/route/widgets/routewidget.dart';

class RouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          iconSize: 26,
          onPressed: () => Navigator.pop(context)
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: RouteWidget(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: RecentAddresses()),
        ],
      ),
    );
  }
}
