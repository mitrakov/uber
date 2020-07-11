import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';

class AddressHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        return RaisedButton(
          child: Container(
            height: 75,
            child: Column(
              children: <Widget>[
                Text(model.startAddress?.toShortString() ?? "From"),
                ListTile(
                  leading: Icon(Icons.stop),
                  title: Text(model.destinationAddress.toShortString() ?? "Where to?"),
                ),
              ],
            ),
          ),
          onPressed: () => Navigator.of(context).pushNamed("/route"),
        );
      },
    );
  }
}
