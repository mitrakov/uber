import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber/address.dart';
import 'package:uber/coordinates.dart';
import 'package:uber/locator.dart';

class MapModel extends Model {
  // model data
  SharedPreferences _storage;
  Coordinates _start;
  Coordinates _destination;
  Marker _startMarker;
  Marker _destinationMarker;
  Address _startAddress;
  Address _destinationAddress;
  Address _predictAddress;
  Polyline _polyline;
  double _distance = 0;

  // coords getters/setters
  Coordinates get start => _start;
  Coordinates get destination => _destination;
  set start(Coordinates value) {
    _start = value;
    Locator.toAddress(_start).then((addr) => _startAddress = addr).whenComplete(notifyListeners);
  }
  set destination(Coordinates value) {
    _destination = value;
    _updateAll().whenComplete(notifyListeners);
  }

  // address getters/setters
  Address get startAddress => _startAddress;
  Address get destinationAddress => _destinationAddress;
  Address get predictAddress => _predictAddress;
  set predictAddress(Address value) {
    Locator.fromAddress(value.addr)
        .then(Locator.toAddress)
        .then((fullAddr) => _predictAddress = fullAddr)
        .whenComplete(notifyListeners);
  }

  // other getters
  double get distance => _distance;
  Set<Polyline> get polylines => _polyline != null ? Set.of([_polyline]) : null;
  Set<Marker> get markers {
    final Set<Marker> result = Set();
    if (_startMarker != null) result.add(_startMarker);
    if (_destinationMarker != null) result.add(_destinationMarker);

    return result;
  }

  List<Address> getRecentAddresses() {
    if (_storage.containsKey("recentAddresses"))
      return _storage.getStringList("recentAddresses").map((s) => Address.fromStorageString(s)).toList();
    return [];
  }

  @override
  String toString() {
    return 'MapModel{_startAddress: $_startAddress, _destinationAddress: $_destinationAddress, _start: $_start, _destination: $_destination, _startMarker: ${_startMarker?.markerId}, _destinationMarker: ${_destinationMarker?.markerId}, _polyline: $_polyline, _distance: $_distance}';
  }

  void init() async {
    if (_storage == null)
      _storage = await SharedPreferences.getInstance();
  }

  Future<void> _updateAll() async {
    _destinationAddress = await Locator.toAddress(_destination);
    _addRecentAddress(_destinationAddress);
    _predictAddress = null;
    _startMarker = _createMarker(_start);
    _destinationMarker = _createMarker(_destination);
    _polyline = await _buildPolyline(_start, _destination);
    _distance = await _calcDistance(_polyline.points);
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

  void _addRecentAddress(Address address) {
    final recentAddresses = getRecentAddresses();
    if (!recentAddresses.contains(address)) {
      recentAddresses.insert(0, address);
      final newList = recentAddresses.take(7).map((a) => a.toStorageString()).toList();
      _storage.setStringList("recentAddresses", newList);
    }
  }
}
