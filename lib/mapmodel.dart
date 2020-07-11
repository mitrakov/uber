import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/address.dart';
import 'package:uber/coordinates.dart';
import 'package:uber/locator.dart';

class MapModel extends Model {
  // model data
  Coordinates _start;
  Coordinates _destination;
  Marker _startMarker;
  Marker _destinationMarker;
  Address _startAddress;
  Address _destinationAddress;
  Polyline _polyline;
  double _distance = 0;

  // coords getters/setters
  Coordinates get start => _start;
  Coordinates get destination => _destination;
  set start(Coordinates value) {
    _start = value;
    _updateModel(_start, _destination).whenComplete(() => notifyListeners());
  }
  set destination(Coordinates value) {
    _destination = value;
    _updateModel(_start, _destination).whenComplete(() => notifyListeners());
  }

  // public getters
  Address get startAddress => _startAddress;
  Address get destinationAddress => _destinationAddress;
  double get distance => _distance;
  Set<Polyline> get polylines => _polyline != null ? Set.of([_polyline]) : null;
  Set<Marker> get markers {
    final Set<Marker> result = Set();
    if (_startMarker != null) result.add(_startMarker);
    if (_destinationMarker != null) result.add(_destinationMarker);

    return result;
  }

  @override
  String toString() {
    return 'MapModel{_start: $_start, _destination: $_destination, _startMarker: $_startMarker, _destinationMarker: $_destinationMarker, _polyline: $_polyline, _distance: $_distance}';
  }

  Future<void> _updateModel(Coordinates c1, Coordinates c2) async {
    if (c1 != null) {
      _startMarker = _createMarker(c1);
      _startAddress = await Locator.toAddress(c1);
    }
    if (c2 != null) {
      _destinationMarker = _createMarker(c2);
      _destinationAddress = await Locator.toAddress(c2);
    }
    if (c1 != null && c2 != null) {
      _polyline = await _buildPolyline(c1, c2);
      _distance = await _calcDistance(_polyline.points);
    }
  }

  Marker _createMarker(Coordinates c) => Marker(markerId: MarkerId("$c"), position: c.toLatLng());

  Future<Polyline> _buildPolyline(Coordinates c1, Coordinates c2) async {
    final PolylinePoints polylinePoints = PolylinePoints();
    final List<LatLng> points = [];

    final result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyBeXMlR9K0vGo8glrh7XkQfIQikusOczcA", c1.toPoint(), c2.toPoint(), travelMode: TravelMode.driving);
    print("Polylines result: ${result.status}; ${result.errorMessage}; points total: ${result.points.length}");
    result.points.forEach((point) {
      points.add(Coordinates.fromPoint(point).toLatLng());
    });

    return Polyline(polylineId: PolylineId("$result"), color: Colors.black87, points: points, width: 3);
  }
  
  Future<double> _calcDistance(List<LatLng> points) async {
    double total = 0.0;
    for (int i=0; i < points.length - 1; ++i) {
      total += await Locator.distanceBetween(Coordinates.fromLatLng(points[i]), Coordinates.fromLatLng(points[i+1]));
    }
    return total / 1000; // m -> km
  }
}
