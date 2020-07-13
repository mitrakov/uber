import 'package:flutter/material.dart';

class PositionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: 90,
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Material(
              color: Colors.black,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Center(child: Text("4 min", style: TextStyle(color: Colors.white, fontSize: 11)))
              ),
            ),
          ),
          Container(
            color: Colors.black,
            height: 25,
            width: 2,
          )
        ],
      ),
    );
  }
}
