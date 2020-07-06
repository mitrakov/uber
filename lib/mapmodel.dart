import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class MapModel extends Model {
  final Set<Marker> markers = Set();
  final Set<Polyline> polylines = Set();

  void addMarker(Marker marker) {
    markers.add(marker);
    notifyListeners();
  }

  void setPolylines(Iterable<Polyline> lines) {
    polylines.clear();
    polylines.addAll(lines);
    notifyListeners();
  }

  @override
  String toString() {
    return 'MapModel{markers: $markers, polylines: $polylines}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapModel && runtimeType == other.runtimeType && setEquals(markers, other.markers) && setEquals(polylines, other.polylines);

  @override
  int get hashCode => markers.hashCode ^ polylines.hashCode;
}
