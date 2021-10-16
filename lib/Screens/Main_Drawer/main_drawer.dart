import 'package:flutter/material.dart';

import '../../Models/routes.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget drawerItem(IconData icon, String text, Function handler) => ListTile(
          leading: Icon(
            icon,
            size: 26,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            text,
            style: TextStyle(
              fontFamily: "RobotoCondensed",
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: handler,
        );

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          drawerItem(
            Icons.restaurant,
            "Meals",
            () => Navigator.of(context).pushReplacementNamed(Routes.Home),
          ),
          drawerItem(
            Icons.settings,
            "Settings",
            () => Navigator.of(context).pushReplacementNamed(Routes.SettingScreen),
          ),
        ],
      ),
    );
  }
}
