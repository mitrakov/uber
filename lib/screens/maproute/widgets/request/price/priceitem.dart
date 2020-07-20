import 'package:flutter/material.dart';

class PriceItem extends StatelessWidget {
  final String sku;
  final int price;

  const PriceItem(this.sku, this.price, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset("assets/$sku.png"),
          Padding(
            padding: EdgeInsets.only(top: 6, bottom: 2),
            child: Text(sku, style: TextStyle(fontSize: 12)),
          ),
          Text("$price r.", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
