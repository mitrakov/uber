import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: SizedBox(
                height: 90,
                child: Column(
                  children: <Widget>[
                    Text("+7 963 883-39-95", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                    Text("mitrakov-artem@yandex.ru", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text("Order history"),
                  onTap: () => Navigator.of(context).pushNamed("/history"),
                ),
                ListTile(
                  title: Text("Payment methods"),
                  onTap: () => Navigator.of(context).pushNamed("/payment"),
                ),
                ListTile(
                  title: Text("My addresses"),
                  onTap: () => Navigator.of(context).pushNamed("/myaddress"),
                ),
                ListTile(
                  title: Text("Promo code"),
                  onTap: () => Navigator.of(context).pushNamed("/promo"),
                ),
                ListTile(
                  title: Text("Settings"),
                  onTap: () => Navigator.of(context).pushNamed("/settings"),
                ),
                ListTile(
                  title: Text("Support"),
                  onTap: () => Navigator.of(context).pushNamed("/support"),
                ),
                ListTile(
                  title: Text("Info"),
                  onTap: () => Navigator.of(context).pushNamed("/info"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
