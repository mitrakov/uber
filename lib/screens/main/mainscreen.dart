import 'package:flutter/material.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/screens/main/widgets/addressheader.dart';
import 'package:uber/screens/main/widgets/mapwidget.dart';
import 'package:uber/screens/main/widgets/mostrecent.dart';

class MainScreen extends StatelessWidget {
  final MapModel model;

  const MainScreen(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MapWidget((coords) {
            if (model.destination == null) // if destination is null, camera move will set start position
              model.start = coords;
          }),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5, top: 20),
              child: IconButton(icon: Icon(Icons.menu, size: 28), onPressed: () => print("Show menu stub")),
            ),
          ),
          Center(
            child: Icon(Icons.arrow_drop_down_circle, size: 48),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 160),
              child: ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: Colors.white,
                      child: SizedBox(width: 32, height: 32, child: Icon(Icons.near_me, size: 22)),
                      onTap: () => print(""),
                    ),
                  )
              ),
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
