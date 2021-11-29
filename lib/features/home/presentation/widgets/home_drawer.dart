import 'package:flutter/material.dart';

import 'drawer_header.dart';
import 'drawer_list_tile.dart';
import 'privacy_policy.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const HomeDrawerHeader(),
          ),
          const Divider(
            height: 1,
          ),
          DrawerListTile(
            text: 'Chronology',
            iconData: Icons.history,
            onTap: () {},
          ),
          const Divider(
            height: 1,
          ),
          DrawerListTile(
            text: 'Settings',
            iconData: Icons.settings,
            onTap: () {},
          ),
          const Divider(
            height: 1,
          ),
          AboutListTile(
            applicationLegalese:'All rights reserved.\n\u{a9}  2021 Ioannis Georgopoulos',
            applicationName: 'Where Did I Park?',
            applicationVersion: '1.0.0',
            applicationIcon: Icon(
              Icons.directions_car_filled_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
     
          ),
        ],
      ),
    );
  }
}
