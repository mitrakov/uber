import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';

class AddressResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        return Container(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20, top: 13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.panorama_fish_eye, size: 12),
                    SizedBox(height: 2),
                    Icon(Icons.fiber_manual_record, size: 8, color: Colors.grey),
                    Icon(Icons.fiber_manual_record, size: 8, color: Colors.grey),
                    Icon(Icons.fiber_manual_record, size: 8, color: Colors.grey),
                    Icon(Icons.fiber_manual_record, size: 8, color: Colors.grey),
                    Icon(Icons.fiber_manual_record, size: 8, color: Colors.grey),
                    Icon(Icons.stop, size: 18),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 18, bottom: 10),
                      child: Text(model.startAddress?.toShortString() ?? "", style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 13, bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(model.destinationAddress?.toShortString() ?? "", style: TextStyle(fontSize: 17, color: Colors.black)),
                                Text(" • 14 min", style: TextStyle(color: Colors.grey)),
                              ]
                            )
                          )
                        ),
                        Icon(Icons.add, size: 30),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
