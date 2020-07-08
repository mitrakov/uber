import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/coordinates.dart';
import 'package:uber/mapmodel.dart';

class MapWidget extends StatefulWidget {
  final ValueChanged<Coordinates> onNewPosition;
  const MapWidget(this.onNewPosition, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MapWidgetState(onNewPosition);
}

class MapWidgetState extends State<MapWidget> {
  final ValueChanged<Coordinates> onNewPosition;
  final _initPos = CameraPosition(target: LatLng(59.9311, 30.3609), zoom: 15.4746);
  GoogleMapController _mapCtrl;

  MapWidgetState(this.onNewPosition);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        print("Rebuilding map with $model");
        checkModel(model);
        return GoogleMap(
          initialCameraPosition: _initPos,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onCameraMove: (position) {
            EasyDebounce.debounce("camera", Duration(milliseconds: 500), () => onNewPosition(Coordinates.fromLatLng(position.target)));
          },
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _mapCtrl = controller;
            moveToCurrentLocation(model);
          },
          markers: model.markers,
          polylines: model.polylines,
        );
      }
    );
  }

  void checkModel(MapModel model) {
    if (model.start != null) {
      if (model.destination != null) {
        final c1 = Coordinates.fromLatLng(model.start.position);
        final c2 = Coordinates.fromLatLng(model.destination.position);
        zoomCameraToAccommodateCoords(c1, c2);
      } else moveToCoords(Coordinates.fromLatLng(model.start.position));
    }
  }

  void moveToCurrentLocation(MapModel model) async {
    final Coordinates coords = Coordinates.fromPosition(await model.geoLocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high));
    print(coords);
    final position = CameraPosition(target: coords.toLatLng(), zoom: 18);
    _mapCtrl.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  void moveToCoords(Coordinates coords) {
    final position = CameraPosition(target: coords.toLatLng(), zoom: 18);
    _mapCtrl.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  void zoomCameraToAccommodateCoords(Coordinates c1, Coordinates c2) {
    final sw = c1.latitude <= c2.latitude ? c1 : c2;
    final ne = c1.latitude <= c2.latitude ? c2 : c1;
    final newBounds = LatLngBounds(northeast: ne.toLatLng(), southwest: sw.toLatLng());
    _mapCtrl.animateCamera(CameraUpdate.newLatLngBounds(newBounds, 100));
  }
}
