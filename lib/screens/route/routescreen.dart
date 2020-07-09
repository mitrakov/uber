import 'package:flutter/material.dart';
import 'package:uber/screens/route/widgets/recentaddresses.dart';
import 'package:uber/screens/route/widgets/routewidget.dart';

class RouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          RouteWidget(),
          Expanded(child: RecentAddresses()),
        ],
      ),
    );
  }
}
