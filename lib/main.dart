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

  GoogleMapController _ctrl;
  //Position _currentPos;

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
              _ctrl = controller;
              moveToCurrentLocation();
            },
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
                        _ctrl.animateCamera(CameraUpdate.zoomIn());
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
                        _ctrl.animateCamera(CameraUpdate.zoomOut());
                      },
                    ),
                  )
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
    final position = CameraPosition(target: LatLng(pos.latitude, pos.longitude), zoom: 18);
    _ctrl.animateCamera(CameraUpdate.newCameraPosition(position));
  }
}
