import 'package:flutter/material.dart';

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
             DrawerListTile(
            text: 'About',
            iconData: Icons.info_outline_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}




