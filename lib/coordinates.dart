import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates(this.latitude, this.longitude);

  factory Coordinates.fromLatLng(LatLng coords) => Coordinates(coords.latitude, coords.longitude);
  factory Coordinates.fromPosition(Position coords) => Coordinates(coords.latitude, coords.longitude);

  LatLng toLatLng() => LatLng(latitude, longitude);
  Position toPosition() => Position(latitude: latitude, longitude: longitude);

  @override
  String toString() => 'Coordinates{latitude: $latitude, longitude: $longitude}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coordinates && runtimeType == other.runtimeType && latitude == other.latitude && longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
