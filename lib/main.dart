import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/screens/main/mainscreen.dart';
import 'package:uber/screens/route/routescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MapModel _model = MapModel();

  @override
  Widget build(BuildContext context) {
    _model.init();
    return ScopedModel<MapModel>(
      model: _model,
      child: MaterialApp(
        title: 'Uber',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: "/main",
        routes: {
          "/main": (context1) => MainScreen(_model),
          "/route": (context1) => RouteScreen(),
        },
      ),
    );
  }
}
