import 'package:flutter/material.dart';

class PriceChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 100, child: ListTile(title: Icon(Icons.directions_car), subtitle: Text("UberX\n171r."))),
          SizedBox(width: 100, child: ListTile(title: Icon(Icons.directions_car), subtitle: Text("Select\n302r."))),
          SizedBox(width: 100, child: ListTile(title: Icon(Icons.directions_car), subtitle: Text("Select+\n365r."))),
          SizedBox(width: 100, child: ListTile(title: Icon(Icons.directions_car), subtitle: Text("Black\n732r."))),
          SizedBox(width: 100, child: ListTile(title: Icon(Icons.directions_car), subtitle: Text("Lux\n1641r."))),
          SizedBox(width: 100, child: ListTile(title: Icon(Icons.directions_car), subtitle: Text("Van\n902r."))),
          SizedBox(width: 100, child: ListTile(title: Icon(Icons.directions_car), subtitle: Text("Kids\n392r."))),
        ],
      ),
    );
  }

}
