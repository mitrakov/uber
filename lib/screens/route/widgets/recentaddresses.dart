import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/address.dart';
import 'package:uber/locator.dart';
import 'package:uber/mapmodel.dart';

class RecentAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context1, child, model) {
        final data = List<Address>.from(model.getRecentAddresses());
        if (model.predictAddress != null)
          data.insert(0, model.predictAddress);
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context2, i) {
            return ListTile(
              leading: Icon(Icons.schedule),
              title: Text(data[i].addr),
              subtitle: Text(data[i].city),
              onTap: () async {
                model.destination = await Locator.fromAddress(data[i].toShortString());
                Navigator.pushNamed(context2, "/maproute");
              },
            );
          },
        );
      }
    );
  }
}
