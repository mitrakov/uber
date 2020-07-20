import 'package:flutter/material.dart';

class PaymentRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset("assets/apple-pay.png"),
        Padding(padding: EdgeInsets.only(left: 10), child: Text("Apple Pay")),
        Expanded(
          child: Align(alignment: Alignment.centerRight, child: Text("Comments, options")),
        ),
      ],
    );
  }
}
