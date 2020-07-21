import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uber/mapmodel.dart';
import 'package:uber/screens/main/widgets/mostrecentitem.dart';

class MostRecent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MapModel>(
      builder: (context, child, model) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: model.getRecentAddresses().map((address) => MostRecentItem(address)).toList(),
        );
      },
    );
  }
}
