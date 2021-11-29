import 'package:flutter/material.dart';

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