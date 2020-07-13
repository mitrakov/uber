import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';

class AddressHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        return RaisedButton(
          padding: EdgeInsets.all(0),
          child: Container(
            height: 58,
            padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3))]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text("From: ${model.startAddress?.toShortString() ?? ""}", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.stop, size: 12),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(model.destinationAddress?.toShortString() ?? "Where to?", style: TextStyle(fontSize: 18)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          onPressed: () => Navigator.pushNamed(context1, "/route"),
        );
      },
    );
  }
}
