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
          itemCount: data.length * 2,
          itemBuilder: (context2, j) {
            if (j.isOdd) return Container(height: 1, width: 100, color: Colors.grey[300]);
            final i = j ~/ 2;
            return listTile(
              leading: Padding(padding: EdgeInsets.only(left: 12, right: 12), child: Icon(Icons.schedule, size: 19)),
              title: Text(data[i].addr, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              subtitle: Text("${data[i].city}, ${data[i].country}", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              onTap: () => buildRoute(context2, model, data[i]),
              contentPadding: EdgeInsets.all(11),
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

  Widget listTile({Widget leading, Widget title, Widget subtitle, GestureTapCallback onTap, contentPadding: EdgeInsetsGeometry}) {
    return Padding(
      padding: contentPadding,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(right: contentPadding.right), child: leading),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    title,
                    SizedBox(height: 2),
                    subtitle
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
