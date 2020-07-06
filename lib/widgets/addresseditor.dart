import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tuple/tuple.dart';
import 'package:uber/coordinates.dart';

class AddressEditor extends StatelessWidget {
  final _geoLocator = Geolocator();
  final _ctrl = TextEditingController();
  final ValueChanged<Coordinates> callback;

  AddressEditor(this.callback, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Tuple2<String, Position>>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _ctrl,
        style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
      suggestionsCallback: searchAddress,
      itemBuilder: (context, suggestion) => ListTile(title: Text(suggestion.item1)),
      animationDuration: Duration(seconds: 0),
      onSuggestionSelected: (addrAndPos) {
        _ctrl.text = addrAndPos.item1;
        callback.call(Coordinates.fromPosition(addrAndPos.item2));
      },
    );
  }

  Future<List<Tuple2<String, Position>>> searchAddress(String address) async {
    final List<Placemark> placemarks = await _geoLocator.placemarkFromAddress(address, localeIdentifier: "ru_RU");
    return placemarks.map((mark) => Tuple2("${mark.name}; ${mark.locality}; ${mark.postalCode}; ${mark.country}", mark.position)).toList();
  }
}
