import 'package:flutter/material.dart';

class MyLocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.grey.withOpacity(0.4),
      color: Colors.transparent,
      elevation: 10,
      child: ClipOval(
        child: InkWell(
          child: Container(
            color: Colors.white,
            height: 32,
            width: 32,
            child: Icon(Icons.near_me, size: 21),
          ),
          onTap: () => print("MyLocation"),
        ),
      ),
    );
  }
}