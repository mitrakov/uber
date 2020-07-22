import 'package:flutter/material.dart';
import 'package:uber/address.dart';

class MostRecentItem extends StatelessWidget {
  final Address address;

  const MostRecentItem(this.address, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        drawIcon(Icons.access_time),
        Container(
          width: 100,
          padding: EdgeInsets.only(top: 18),
          child: Text(address?.toShortString() ?? "", softWrap: true, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget drawIcon(IconData icon) {
    return Material(
      color: Colors.lightBlue,
      shape: CircleBorder(),
      shadowColor: Colors.black,
      elevation: 8,
      child: Ink(
        width: 57,
        height: 57,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: CircleBorder(),
        ),
        child: IconButton(
          padding: EdgeInsets.all(0),
          iconSize: 22,
          icon: Icon(icon),
          color: Colors.black,
          onPressed: () {},
        ),
      ),
    );
  }

}

