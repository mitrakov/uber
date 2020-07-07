import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class MapModel extends Model {
  Marker start;
  Marker destination;

  Set<Marker> get markers {
    final Set<Marker> result = Set();
    if (start != null) result.add(start);
    if (destination != null) result.add(destination);

    return result;
  }

  void setStart(Marker marker) {
    start = marker;
    notifyListeners();
  }

  void setDestination(Marker marker) {
    destination = marker;
    notifyListeners();
  }

  @override
  String toString() {
    return 'MapModel{start: $start, destination: $destination}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapModel && runtimeType == other.runtimeType && start == other.start && destination == other.destination;

  @override
  int get hashCode => start.hashCode ^ destination.hashCode;
}
