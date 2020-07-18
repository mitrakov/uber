import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/coordinates.dart';
import 'package:uber/locator.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/screens/main/widgets/addressheader.dart';
import 'package:uber/screens/main/widgets/maindrawer.dart';
import 'package:uber/screens/main/widgets/mapwidget.dart';
import 'package:uber/screens/main/widgets/mostrecent.dart';
import 'package:uber/screens/main/widgets/mylocationwidget.dart';
import 'package:uber/screens/main/widgets/positionwidget.dart';

class MainScreen extends StatefulWidget {
  final MapModel model;
  MainScreen(this.model, {Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GoogleMapController mapCtrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: Stack(
        children: <Widget>[
          MapWidget((ctrl) {mapCtrl = ctrl; moveToCurrentLocation();}, (coords) {widget.model.start = coords;}),
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
              child: MyLocationWidget(() => moveToCurrentLocation()),
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

  void moveToCurrentLocation() async {
    final Coordinates coords = await Locator.getCurrentPosition();
    print("Moving to $coords");
    final position = CameraPosition(target: coords.toLatLng(), zoom: 18);
    mapCtrl.animateCamera(CameraUpdate.newCameraPosition(position));
  }
}
