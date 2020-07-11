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
        return FutureBuilder<List<Address>>(
          future: getAddresses(),
          initialData: [],
          builder: (context2, snapshot) {
            if (snapshot.hasData) {
              final data = List<Address>.from(snapshot.data);
              if (model.predictAddress != null)
                data.insert(0, model.predictAddress);
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context3, i) {
                  return ListTile(
                    leading: Icon(Icons.schedule),
                    title: Text(data[i].addr),
                    subtitle: Text(data[i].city),
                    onTap: () async {
                      model.destination = await Locator.fromAddress(data[i].toShortString());
                      Navigator.of(context3).pop();
                    },
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        );
      }
    );
  }

  Future<List<Address>> getAddresses() {
    return Future.value([
      Address("Tsvetochnaya ulitsa, 16к3Б", "Saint Petersburg", "Russia"),
      Address("metro Obvodny Kanal", "Line 5, Saint Petersburg", "Russia"),
      Address("Kuznechny Pereulok, 13", "Saint Petersburg", "Russia"),
      Address("11-ya liniya Vasilyevskogo ostrova, 32/44", "Saint Petersburg", "Russia"),
      Address("Komendantskaya Square, 8", "Saint Petersburg", "Russia"),
    ]);
  }
}
