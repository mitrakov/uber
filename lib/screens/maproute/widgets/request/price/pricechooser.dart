import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/redux/appstate.dart';
import 'package:uber/screens/maproute/widgets/request/price/priceitem.dart';

class PriceChooser extends StatefulWidget {
  @override
  _PriceChooserState createState() => _PriceChooserState();
}

class _PriceChooserState extends State<PriceChooser> {
  String selectedSku = "UberX";

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        return StoreConnector<AppState, AppState>(
          distinct: true,
          converter: (store) => store.state,
          builder: (context2, state) {
            return Container(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.prices.length,
                itemBuilder: (context3, i) {
                  final sku = state.prices.keys.toList()[i];
                  final price = state.prices.values.toList()[i];
                  return Align(alignment: Alignment.bottomCenter, child: PriceItem(sku, price, sku == selectedSku, onTap: (sku) {
                    setState(() => selectedSku = sku);
                  }));
                },
              ),
            );
          },
        );
      },
    );
  }
}
