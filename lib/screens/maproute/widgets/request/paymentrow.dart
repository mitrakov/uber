import 'package:flutter/material.dart';

class PaymentRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset("assets/apple-pay.png"),
          Padding(padding: EdgeInsets.only(left: 10), child: Text("Apple Pay", style: TextStyle(fontSize: 12))),
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: Text("Comments, options", style: TextStyle(fontSize: 12))),
          ),
        ],
      ),
    );
  }
}
