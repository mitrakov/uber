import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/coordinates.dart';
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
  final _startCtrl = TextEditingController();

  UberState(this.model);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MapModel>(
      model: model,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
          MapWidget(coordsToStr),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5, top: 20),
              child: IconButton(icon: Icon(Icons.menu, size: 28), onPressed: () => print("Show menu stub")),
            ),
          ),
          Center(
            child: Icon(Icons.arrow_drop_down_circle, size: 48),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 160),
              child: ClipOval(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    splashColor: Colors.white,
                    child: SizedBox(width: 32, height: 32, child: Icon(Icons.near_me, size: 22)),
                    onTap: () => print(""),
                  ),
                )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 70, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: SizedBox(width: 57, height: 57, child: Icon(Icons.access_time, size: 27)),
                          onTap: () {
                            //_mapCtrl.animateCamera(CameraUpdate.zoomIn());
                          },
                        ),
                      )
                  ),
                  ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: SizedBox(width: 57, height: 57, child: Icon(Icons.access_time, size: 27)),
                          onTap: () {
                            //_mapCtrl.animateCamera(CameraUpdate.zoomOut());
                          },
                        ),
                      )
                  ),
                  ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: SizedBox(width: 57, height: 57, child: Icon(Icons.access_time, size: 27)),
                          onTap: () {
                            //_mapCtrl.animateCamera(CameraUpdate.zoomOut());
                          },
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 100, right: 22),
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                AddressEditor((coords) => model.start = Marker(markerId: MarkerId("$coords"), position: coords.toLatLng()), controller: _startCtrl),
//                AddressEditor((coords) => model.destination = Marker(markerId: MarkerId("$coords"), position: coords.toLatLng())),
//                Text("Distance: ${model.distance.toStringAsFixed(2)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
//              ],
//            ),
            child: buildTextField(controller: TextEditingController(text: "Where to?"), label: "From: Strelbishchenskaya ulitsa, 29", hint: "Strelbyshchenskaya", initValue: "Strelbyshchenskaya", prefixIcon: Icon(Icons.stop, size: 12, color: Colors.black)),
          )
          ],
        ),
      )
    );
  }

  void coordsToStr(Coordinates coords) async {
    List<Placemark> marks = await model.geoLocator.placemarkFromPosition(coords.toPosition());
    if (marks.isNotEmpty) {
      Placemark mark = marks.first;
      _startCtrl.text = "${mark.name}; ${mark.locality}; ${mark.postalCode}; ${mark.country}";
    }
  }

  Widget buildTextField({TextEditingController controller, String label, String hint, String initValue, Widget prefixIcon, Widget suffixIcon, Function(String) callback}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 2, blurRadius: 15, offset: Offset(0, 7)),
        ]
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) => callback(value),
        style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          prefixIcon: Padding(padding: EdgeInsets.only(top: 17), child: prefixIcon),
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          hintText: hint,
        ),
      ),
    );
  }
}
