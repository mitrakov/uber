import 'package:flutter/material.dart';

class MyLocationWidget extends StatelessWidget {
  final GestureTapCallback onTap;

  const MyLocationWidget(this.onTap, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue,
      shape: CircleBorder(),
      shadowColor: Colors.black,
      elevation: 8,
      child: Ink(
        width: 32,
        height: 32,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: CircleBorder(),
        ),
        child: IconButton(
          padding: EdgeInsets.all(0),
          iconSize: 21,
          icon: Icon(Icons.near_me),
          color: Colors.black87,
          onPressed: onTap,
        ),
      ),
    );
  }
}
