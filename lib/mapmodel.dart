import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/coordinates.dart';

class MapModel extends Model {
  final geoLocator = Geolocator();

  Marker _start;
  Marker _destination;
  Polyline _polyline;
  double _distance = 0;

  Marker get start => _start;
  Marker get destination => _destination;
  double get distance => _distance;
  Set<Polyline> get polylines => _polyline != null ? Set.of([_polyline]) : null;
  Set<Marker> get markers {
    final Set<Marker> result = Set();
    if (_start != null) result.add(_start);
    if (_destination != null) result.add(_destination);

    return result;
  }

  set start(Marker marker) {
    _start = marker;
    if (_destination != null)
      _buildPolylines(Coordinates.fromLatLng(_start.position), Coordinates.fromLatLng(_destination.position));
    else notifyListeners();
  }

  set destination(Marker marker) {
    _destination = marker;
    if (_start != null)
      _buildPolylines(Coordinates.fromLatLng(_start.position), Coordinates.fromLatLng(_destination.position));
    else notifyListeners();
  }

  void _buildPolylines(Coordinates c1, Coordinates c2) async {
    final PolylinePoints polylinePoints = PolylinePoints();
    final List<LatLng> points = [];
    double total = 0.0;

    final result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyBeXMlR9K0vGo8glrh7XkQfIQikusOczcA", c1.toPoint(), c2.toPoint(), travelMode: TravelMode.driving);
    print("Polylines result: ${result.status}; ${result.errorMessage}; points total: ${result.points.length}");
    result.points.forEach((point) {
      points.add(Coordinates.fromPoint(point).toLatLng());
    });
    for (int i=0; i < points.length - 1; ++i) {
      total += await geoLocator.distanceBetween(points[i].latitude, points[i].longitude, points[i+1].latitude, points[i+1].longitude);
    }

    _polyline = Polyline(polylineId: PolylineId("$result"), color: Colors.black87, points: points, width: 3);
    _distance = total / 1000; // m -> km
    notifyListeners();
  }

  @override
  String toString() {
    return 'MapModel{start: $_start, destination: $_destination, polyline: $_polyline, distance: $_distance}';
  }
}
