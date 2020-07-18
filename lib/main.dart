import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/redux/appstate.dart';
import 'package:uber/redux/reducers.dart';
import 'package:uber/screens/history/history.dart';
import 'package:uber/screens/info/info.dart';
import 'package:uber/screens/main/mainscreen.dart';
import 'package:uber/screens/maproute/maproutescreen.dart';
import 'package:uber/screens/myaddress/myaddress.dart';
import 'package:uber/screens/payment/payments.dart';
import 'package:uber/screens/promo/promo.dart';
import 'package:uber/screens/route/routescreen.dart';
import 'package:uber/screens/settings/settings.dart';
import 'package:uber/screens/support/support.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> _store = Store<AppState>(AppReducer.reducer, initialState: AppState({}, ""), middleware: [thunkMiddleware]);
  final MapModel _model = MapModel();

  @override
  Widget build(BuildContext context) {
    _model.init();
    return StoreProvider(
      store: _store,
      child: ScopedModel<MapModel>(
        model: _model,
        child: MaterialApp(
          title: 'Uber',
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: "/main",
          routes: {
            "/main": (context1) => MainScreen(),
            "/route": (context1) => RouteScreen(),
            "/maproute": (context1) => MapRouteScreen(),
            "/history": (context1) => HistoryScreen(),
            "/payment": (context1) => PaymentsScreen(),
            "/myaddress": (context1) => MyAddressesScreen(),
            "/promo": (context1) => PromoScreen(),
            "/settings": (context1) => SettingsScreen(),
            "/support": (context1) => SupportScreen(),
            "/info": (context1) => InfoScreen(),
          },
        ),
      )
    );
  }
}
