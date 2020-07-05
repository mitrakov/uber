import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uber',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Uber(),
    );
  }
}

class Uber extends StatefulWidget {
  @override
  State<Uber> createState() => UberState();
}

class UberState extends State<Uber> {
  final _geoLocator = Geolocator();
  final CameraPosition _initPos = CameraPosition(target: LatLng(59.9311, 30.3609), zoom: 15.4746);
  final TextEditingController _startAdderessCtrl = TextEditingController();
  final TextEditingController _endAdderessCtrl = TextEditingController();
  final Set<Marker> _markers = Set();

  GoogleMapController _mapCtrl;
  Position _currentPos;
  Position _startPos;
  Position _endPos;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: _initPos,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _mapCtrl = controller;
              moveToCurrentLocation();
            },
            markers: _markers,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: ClipOval(
                child: Material(
                  color: Colors.lightGreen,
                  child: InkWell(
                    splashColor: Colors.green,
                    child: SizedBox(width: 56, height: 56, child: Icon(Icons.my_location)),
                    onTap: () => moveToCurrentLocation(),
                  ),
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: Colors.blue[100],
                    child: InkWell(
                      splashColor: Colors.blue,
                      child: SizedBox(width: 50, height: 50, child: Icon(Icons.add)),
                      onTap: () {
                        _mapCtrl.animateCamera(CameraUpdate.zoomIn());
                      },
                    ),
                  )
                ),
                SizedBox(height: 10),
                ClipOval(
                  child: Material(
                    color: Colors.blue[100],
                    child: InkWell(
                      splashColor: Colors.blue,
                      child: SizedBox(width: 50, height: 50, child: Icon(Icons.remove)),
                      onTap: () {
                        _mapCtrl.animateCamera(CameraUpdate.zoomOut());
                      },
                    ),
                  )
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                buildTextField(controller: _startAdderessCtrl, label: "Start", hint: "Start address", prefixIcon: Icon(Icons.looks_one), callback: (s) => findStartAddress()),
                buildTextField(controller: _endAdderessCtrl, label: "Destination", hint: "Destination address", prefixIcon: Icon(Icons.looks_two), callback: (s) => findDestinationAddress()),
                RaisedButton(
                  child: Text("Build route"),
                  color: Colors.blue[200],
                  onPressed: () => placeMarkers(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  
  void moveToCurrentLocation() async {
    final Position pos = await _geoLocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(pos);
    _currentPos = pos;
    final position = CameraPosition(target: LatLng(pos.latitude, pos.longitude), zoom: 18);
    _mapCtrl.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  void findStartAddress() async {
    final List<Placemark> placemarks = await _geoLocator.placemarkFromPosition(_currentPos);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      final addr = "${placemark.name}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}";
      _startAdderessCtrl.text = addr;
      _startPos = placemark.position;
    }
  }

  void findDestinationAddress() async {
    final List<Placemark> placemarks = await _geoLocator.placemarkFromAddress(_endAdderessCtrl.text);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      print("${placemark.name}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}");
      _endPos = placemark.position;
    }
  }

  void placeMarkers() {
    final startMarker = Marker(
      markerId: MarkerId("$_startPos"),
      position: LatLng(_startPos.latitude, _startPos.longitude),
      infoWindow: InfoWindow(title: "Start", snippet: _startAdderessCtrl.text),
      icon: BitmapDescriptor.defaultMarker,
    );
    final destinationMarker = Marker(
      markerId: MarkerId("$_endPos"),
      position: LatLng(_endPos.latitude, _endPos.longitude),
      infoWindow: InfoWindow(title: "Destination", snippet: _endAdderessCtrl.text),
      icon: BitmapDescriptor.defaultMarker,
    );

    setState(() {
      _markers.addAll([startMarker, destinationMarker]);
    });
    zoomCameraForMarkers();
  }

  void zoomCameraForMarkers() {
    final sw = _startPos.latitude <= _endPos.latitude ? _startPos : _endPos;
    final ne = _startPos.latitude <= _endPos.latitude ? _endPos : _startPos;

    final newBounds = LatLngBounds(northeast: LatLng(ne.latitude, ne.longitude), southwest: LatLng(sw.latitude, sw.longitude));
    _mapCtrl.animateCamera(CameraUpdate.newLatLngBounds(newBounds, 80));
  }

  Widget buildTextField({TextEditingController controller, String label, String hint, String initValue, Widget prefixIcon, Widget suffixIcon, Function(String) callback}) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: TextField(
        controller: controller,
        onChanged: (value) => callback(value),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white70,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.grey[400], width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blue[300], width: 2),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }
}
