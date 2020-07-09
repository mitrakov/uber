import 'package:flutter/material.dart';
import 'package:uber/address.dart';

class RecentAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Address>>(
      future: getAddresses(),
      initialData: [],
      builder: (context1, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context2, i) {
              return ListTile(
                leading: Icon(Icons.schedule),
                title: Text(snapshot.data[i].addr),
                subtitle: Text(snapshot.data[i].city),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error);
        } else return CircularProgressIndicator();
      },
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
