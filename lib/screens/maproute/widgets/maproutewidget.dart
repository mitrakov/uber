import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/coordinates.dart';
import 'package:uber/mapmodel.dart';

class MapRouteWidget extends StatefulWidget {
  State<StatefulWidget> createState() => _MapRouteWidgetState();
}

class _MapRouteWidgetState extends State<MapRouteWidget> {
  static const TIMER_WIDTH = 35.0;
  static const TIMER_HEIGHT = 28.0;

  GoogleMapController mapCtrl;
  int _timerPosX = 100;
  int _timerPosY = 100;
  bool _timerVisible = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        print("Rebuilding route map with");
        return Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(target: model.start.toLatLng(), zoom: 15.4746),
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                mapCtrl = controller;
                Future.delayed(Duration(milliseconds: 1000), () => zoomCameraToAccommodateCoords(model.start, model.destination));
              },
              markers: model.markers,
              polylines: model.polylines,
            ),
            Padding(
              padding: EdgeInsets.only(left: _timerPosX.toDouble() - TIMER_WIDTH/2, top: _timerPosY.toDouble() - 1.8*TIMER_HEIGHT),
              child: _timerVisible ? Container(
                padding: EdgeInsets.all(2),
                color: Colors.black,
                width: TIMER_WIDTH,
                height: TIMER_HEIGHT,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("8", style: TextStyle(color: Colors.white, fontSize: 11)),
                    Text("min", style: TextStyle(color: Colors.white, fontSize: 9)),
                  ],
                ),
              ) : SizedBox.shrink(),
            ),
          ],
        );
      }
    );
  }

  void zoomCameraToAccommodateCoords(Coordinates c1, Coordinates c2) {
    if (c1 == null || c2 == null) return;

    final sw = c1.latitude <= c2.latitude ? c1 : c2;
    final ne = c1.latitude <= c2.latitude ? c2 : c1;
    final newBounds = LatLngBounds(northeast: ne.toLatLng(), southwest: sw.toLatLng());
    mapCtrl.animateCamera(CameraUpdate.newLatLngBounds(newBounds, 80)).then((_) {
      Future.delayed(Duration(milliseconds: 600), () async {
        final screenCoords = await mapCtrl.getScreenCoordinate(c1.toLatLng());
        setState(() {
          _timerPosX = screenCoords.x;
          _timerPosY = screenCoords.y;
          _timerVisible = true;
        });
      });
    });
  }
}
