import 'package:flutter/material.dart';

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