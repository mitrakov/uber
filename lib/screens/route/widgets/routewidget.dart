import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/address.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/screens/route/widgets/addresseditor.dart';
import 'package:uber/screens/route/widgets/linepoints.dart';

class RouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        return Padding(
          padding: EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 22, right: 15, bottom: 10),
                child: LinePoints(),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    AddressEditor(model.startAddress?.toShortString() ?? "", (addr) {}),
                    AddressEditor("Where to?", (addr) => model.predictAddress = Address.predict(addr)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.add, size: 28),
              ),
            ],
          ),
        );
      },
    );
  }
}
