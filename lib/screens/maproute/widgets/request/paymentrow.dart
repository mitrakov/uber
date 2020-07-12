import 'package:flutter/material.dart';

class PaymentRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(Icons.payment),
        Text("Apple Pay"),
        Text("Comments, options"),
      ],
    );
  }
}
