import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onTap;
  const DrawerListTile({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Row(
        children: [
          Text(
            text,
            style: theme.textTheme.headline6?.copyWith(
              color: theme.colorScheme.primaryVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            iconData,
            size: 30,
            color: theme.colorScheme.primaryVariant,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class HomeDrawerHeader extends StatelessWidget {
  const HomeDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
      ),
      child: Column(
        children: [
          Text(
            'Where Did I Park?',
            style: theme.textTheme.headline5?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.directions_car_filled_rounded,
            color: theme.colorScheme.onPrimary,
            size: 100,
          )
        ],
      ),
    );
  }
}
