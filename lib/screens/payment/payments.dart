import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: Text("Payment methods")),
      body: Center(
        child: Text("Payment methods"),
      ),
    );
  }
}
