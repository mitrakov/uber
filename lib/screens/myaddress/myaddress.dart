import 'package:flutter/material.dart';

class MyAddressesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: Text("My addresses")),
      body: Center(
        child: Text("My addresses"),
      ),
    );
  }
}
