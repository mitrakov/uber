import 'package:flutter/material.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/screens/main/widgets/addressheader.dart';
import 'package:uber/screens/main/widgets/maindrawer.dart';
import 'package:uber/screens/main/widgets/mapwidget.dart';
import 'package:uber/screens/main/widgets/mostrecent.dart';
import 'package:uber/screens/main/widgets/mylocationwidget.dart';
import 'package:uber/screens/main/widgets/positionwidget.dart';

class MainScreen extends StatelessWidget {
  final MapModel model;

  const MainScreen(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: Stack(
        children: <Widget>[
          MapWidget((coords) {model.start = coords;}),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5, top: 20),
              child: Builder(
                builder: (context1) => IconButton(icon: Icon(Icons.menu, size: 28), onPressed: () => Scaffold.of(context1).openDrawer()),
              ),
            ),
          ),
          Center(child: PositionWidget()),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 160),
              child: MyLocationWidget(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 70, left: 20, right: 20),
              child: MostRecent(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 100, right: 22),
            child: AddressHeader(),
          )
        ],
      ),
    );
  }
}
