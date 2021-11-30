import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:where_i_park/features/chronology/presentation/pages/chronology_screen.dart';
import 'package:where_i_park/features/settings/presentation/pages/settings_screen.dart';

import 'drawer_header.dart';
import 'drawer_list_tile.dart';

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
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) {
                    return const ChronologyScreen();
                  },
                ),
              );
            },
          ),
          const Divider(
            height: 1,
          ),
          DrawerListTile(
            text: 'Settings',
            iconData: Icons.settings,
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) {
                    return const SettingsScreen();
                  },
                ),
              );
            },
          ),
          const Divider(
            height: 1,
          ),
          AboutListTile(
            applicationLegalese:
                'All rights reserved.\n\u{a9}  2021 Ioannis Georgopoulos',
            applicationName: 'Where Did I Park?',
            applicationVersion: '1.0.0',
            icon: const Icon(
              Icons.info_outline_rounded,
            ),
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
