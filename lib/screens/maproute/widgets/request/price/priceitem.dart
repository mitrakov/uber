import 'package:flutter/material.dart';

class PriceItem extends StatelessWidget {
  final String sku;
  final int price;

  const PriceItem(this.sku, this.price, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset("assets/$sku.png"),
          Text(sku),
          Text("$price r.", style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
