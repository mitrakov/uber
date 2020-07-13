import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/redux/appstate.dart';

class PriceChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        return StoreConnector<AppState, AppState>(
          distinct: true,
          converter: (store) => store.state,
          builder: (context2, state) {
            return Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.prices.length,
                itemBuilder: (context3, i) {
                  final sku = state.prices.keys.toList()[i];
                  final price = state.prices.values.toList()[i].toStringAsFixed(0);
                  return SizedBox(width: 100, child: ListTile(title: Icon(Icons.directions_car), subtitle: Text("$sku\n$price₽")));
                },
              ),
            );
          },
        );
      },
    );
  }
}
