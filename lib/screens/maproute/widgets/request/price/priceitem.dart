import 'package:flutter/material.dart';

class PriceItem extends StatelessWidget {
  final String sku;
  final int price;
  final bool selected;
  final ValueChanged<String> onTap;

  const PriceItem(this.sku, this.price, this.selected, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(sku),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset("assets/$sku.png"),
            Padding(
              padding: EdgeInsets.only(top: 6, bottom: 2),
              child: Text(sku, style: TextStyle(fontSize: 12)),
            ),
            Text("$price r.", style: TextStyle(fontSize: 18, fontWeight: selected ? FontWeight.w800 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
