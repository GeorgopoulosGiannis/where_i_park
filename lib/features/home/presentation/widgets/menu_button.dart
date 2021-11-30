import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onTap;
  const MenuButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        right: 15.0,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          Icons.menu,
          color: theme.colorScheme.primaryVariant,
          size: 40,
        ),
      ),
    );
  }
}
