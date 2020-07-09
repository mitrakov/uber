import 'package:geolocator/geolocator.dart';
import 'package:uber/address.dart';
import 'package:uber/coordinates.dart';

class Locator {
  static final Geolocator locator = Geolocator();

  static Future<Address> toAddress(Coordinates coords) async {
    print("Hey");
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
}
