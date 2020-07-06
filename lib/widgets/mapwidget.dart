import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';

class MapWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  final _initPos = CameraPosition(target: LatLng(59.9311, 30.3609), zoom: 15.4746);
  GoogleMapController _mapCtrl;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        print("Rebuilding map with $model");
        return GoogleMap(
          initialCameraPosition: _initPos,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _mapCtrl = controller;
            //moveToCurrentLocation();
          },
          markers: model.markers,
          polylines: model.polylines,
        );
      }
    );
  }
}
