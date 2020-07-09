import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/address.dart';
import 'package:uber/locator.dart';
import 'package:uber/mapmodel.dart';

class AddressHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        print("Opana");
        return RaisedButton(
          child: Container(
            height: 75,
            child: Column(
              children: <Widget>[
                FutureBuilder<Address>(
                  future: Locator.toAddress(model.startCoords),
                  initialData: Address("", "", ""),
                  builder: (context2, snapshot) {
                    if (snapshot.hasData)
                      return Text(snapshot.data.toShortString());
                    return CircularProgressIndicator();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.stop),
                  title: Text("Where to?"),
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
