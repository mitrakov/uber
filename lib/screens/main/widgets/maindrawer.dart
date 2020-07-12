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
                  onTap: () => Navigator.pushNamed(context, "/history"),
                ),
                ListTile(
                  title: Text("Payment methods"),
                  onTap: () => Navigator.pushNamed(context, "/payment"),
                ),
                ListTile(
                  title: Text("My addresses"),
                  onTap: () => Navigator.pushNamed(context, "/myaddress"),
                ),
                ListTile(
                  title: Text("Promo code"),
                  onTap: () => Navigator.pushNamed(context, "/promo"),
                ),
                ListTile(
                  title: Text("Settings"),
                  onTap: () => Navigator.pushNamed(context, "/settings"),
                ),
                ListTile(
                  title: Text("Support"),
                  onTap: () => Navigator.pushNamed(context, "/support"),
                ),
                ListTile(
                  title: Text("Info"),
                  onTap: () => Navigator.pushNamed(context, "/info"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
