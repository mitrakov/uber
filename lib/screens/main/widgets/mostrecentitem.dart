import 'package:flutter/material.dart';

class MostRecentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.white,
          child: SizedBox(width: 57, height: 57, child: Icon(Icons.access_time, size: 27)),
          onTap: () {
            //_mapCtrl.animateCamera(CameraUpdate.zoomIn());
          },
        ),
      ),
    );
  }
}
