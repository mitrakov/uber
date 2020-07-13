import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/address.dart';
import 'package:uber/locator.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/redux/appstate.dart';
import 'package:uber/redux/thunks.dart';

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
              onTap: () => buildRoute(context2, model, data[i]),
            );
          },
        );
      }
    );
  }

  void buildRoute(BuildContext context, MapModel model, Address address) async {
    model.destination = await Locator.fromAddress(address.toShortString());
    StoreProvider.of<AppState>(context).dispatch(Thunk.fetchPrices(model.start, model.destination));
    Navigator.pushNamed(context, "/maproute");
  }
}
