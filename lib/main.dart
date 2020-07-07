import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/widgets/addresseditor.dart';
import 'package:uber/widgets/mapwidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uber',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Uber(MapModel()),
    );
  }
}

class Uber extends StatefulWidget {
  final MapModel model;
  const Uber(this.model, {Key key}) : super(key: key);

  @override
  State<Uber> createState() => UberState(model);
}

class UberState extends State<Uber> {
  final MapModel model;
  final _geoLocator = Geolocator();

  final TextEditingController _startAdderessCtrl = TextEditingController();
  final TextEditingController _endAdderessCtrl = TextEditingController();

  Position _currentPos;
  Position _startPos;
  Position _endPos;
  String _distance = "Distance";

  UberState(this.model);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MapModel>(
      model: model,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
          MapWidget(),
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
                    onTap: () => print(""),
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
                        //_mapCtrl.animateCamera(CameraUpdate.zoomIn());
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
                          //_mapCtrl.animateCamera(CameraUpdate.zoomOut());
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
                //buildTextField(controller: _startAdderessCtrl, label: "Start", hint: "Start address", prefixIcon: Icon(Icons.looks_one), callback: (s) => findStartAddress()),
                //buildTextField(controller: _endAdderessCtrl, label: "Destination", hint: "Destination address", prefixIcon: Icon(Icons.looks_two), callback: (s) => findDestinationAddress()),
                AddressEditor((coords) => model.setStart(Marker(markerId: MarkerId("$coords"), position: coords.toLatLng()))),
                AddressEditor((coords) => model.setDestination(Marker(markerId: MarkerId("$coords"), position: coords.toLatLng()))),
                RaisedButton(
                  child: Text("Place markers"),
                  color: Colors.blue[200],
                  onPressed: () => placeMarkers(),
                ),
                RaisedButton(
                  child: Text("Build Route"),
                  color: Colors.blue[200],
                  onPressed: () {
                    totalDistance();
                  },
                ),
                Text(_distance, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              ],
            ),
          )
          ],
        ),
      )
    );
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
      //_markers.addAll([startMarker, destinationMarker]);
      //zoomCameraForMarkers();
    });
  }





  void totalDistance() async {
//    final points = _polylines.values.first.points; // TODO dangerous
//    double total = 0.0;
//    for (int i=0; i < points.length - 1; ++i) {
//      total += await _geoLocator.distanceBetween(points[i].latitude, points[i].longitude, points[i+1].latitude, points[i+1].longitude);
//    }
//    total /= 1000; // m -> km
//    setState(() {
//      _distance = "Distance: ${total.toStringAsFixed(2)} km";
//    });
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
