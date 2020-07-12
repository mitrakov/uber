import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';

class AddressResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        return Container(
          child: Column(
            children: <Widget>[
              Text(model.startAddress.toShortString()),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(child: Text(model.startAddress.toShortString())),
                  Text("14 min", style: TextStyle(color: Colors.grey)),
                  Icon(Icons.add),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
