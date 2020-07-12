import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/screens/history/history.dart';
import 'package:uber/screens/info/info.dart';
import 'package:uber/screens/main/mainscreen.dart';
import 'package:uber/screens/myaddress/myaddress.dart';
import 'package:uber/screens/payment/payments.dart';
import 'package:uber/screens/promo/promo.dart';
import 'package:uber/screens/route/routescreen.dart';
import 'package:uber/screens/settings/settings.dart';
import 'package:uber/screens/support/support.dart';

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
          "/history": (context1) => HistoryScreen(),
          "/payment": (context1) => PaymentsScreen(),
          "/myaddress": (context1) => MyAddressesScreen(),
          "/promo": (context1) => PromoScreen(),
          "/settings": (context1) => SettingsScreen(),
          "/support": (context1) => SupportScreen(),
          "/info": (context1) => InfoScreen(),
        },
      ),
    );
  }
}
