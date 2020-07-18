import 'package:flutter/material.dart';
import 'package:uber/screens/maproute/widgets/request/addressresult.dart';
import 'package:uber/screens/maproute/widgets/request/paymentrow.dart';
import 'package:uber/screens/maproute/widgets/request/price/pricechooser.dart';

class RequestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          AddressResult(),
          Divider(),
          PriceChooser(),
          Divider(),
          PaymentRow(),
          RaisedButton(
            color: Colors.black,
            child: Text("REQUEST UBERX", style: TextStyle(color: Colors.white)),
            onPressed: () => print("REQUEST UBERX"),
          ),
        ],
      ),
    );
  }
}
