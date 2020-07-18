import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/coordinates.dart';
import 'package:uber/mapmodel.dart';

class MapWidget extends StatelessWidget {
  final ValueChanged<GoogleMapController> onMapCreated;
  final ValueChanged<Coordinates> onNewPosition;
  const MapWidget(this.onMapCreated, this.onNewPosition, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        print("Rebuilding map with $model");
        return GoogleMap(
          initialCameraPosition: CameraPosition(target: Coordinates.fallback().toLatLng(), zoom: 15.4746),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onCameraMove: (position) {
            EasyDebounce.debounce("camera", Duration(milliseconds: 500), () => onNewPosition(Coordinates.fromLatLng(position.target)));
          },
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: onMapCreated,
        );
      }
    );
  }
}
