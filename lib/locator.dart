import 'package:geolocator/geolocator.dart';
import 'package:uber/address.dart';
import 'package:uber/coordinates.dart';

class Locator {
  static final Geolocator locator = Geolocator();

  static Future<Address> toAddress(Coordinates coords) async {
    try {
      final List<Placemark> list = await locator.placemarkFromPosition(coords.toPosition());
      if (list.isNotEmpty) {
        final placemark = list.first;
        return Address(placemark.name, placemark.locality, placemark.country);
      }
      return Address("", "", ""); // TODO Option
    } catch (e) {
      return Address("", "", ""); // TODO Option
    }
  }

  static Future<Coordinates> fromAddress(String address) async {
    try {
      final List<Placemark> list = await locator.placemarkFromAddress(address, localeIdentifier: "ru_RU");
      if (list.isNotEmpty) {
        return Coordinates.fromPosition(list.first.position);
      }
      return Coordinates.fallback();
    } catch (e) {
      return Coordinates.fallback();
    }
  }

  static Future<double> distanceBetween(Coordinates c1, Coordinates c2) {
    return locator.distanceBetween(c1.latitude, c1.longitude, c2.latitude, c2.longitude);
  }

  static Future<Coordinates> getCurrentPosition() async {
    Position p = await locator.getCurrentPosition();
    return Coordinates.fromPosition(p);
  }
}
