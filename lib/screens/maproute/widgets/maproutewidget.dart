import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/coordinates.dart';
import 'package:uber/mapmodel.dart';

class MapRouteWidget extends StatefulWidget {
  State<StatefulWidget> createState() => _MapRouteWidgetState();
}

class _MapRouteWidgetState extends State<MapRouteWidget> {
  GoogleMapController mapCtrl;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        print("Rebuilding route map with");
        return GoogleMap(
          initialCameraPosition: CameraPosition(target: model.start.toLatLng(), zoom: 15.4746),
          myLocationEnabled: true,
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
        );
      }
    );
  }

  void zoomCameraToAccommodateCoords(Coordinates c1, Coordinates c2) {
    if (c1 == null || c2 == null) return;

    final sw = c1.latitude <= c2.latitude ? c1 : c2;
    final ne = c1.latitude <= c2.latitude ? c2 : c1;
    final newBounds = LatLngBounds(northeast: ne.toLatLng(), southwest: sw.toLatLng());
    mapCtrl.animateCamera(CameraUpdate.newLatLngBounds(newBounds, 100));
  }
}
