import 'package:flutter/material.dart';

class ShareLocationMenuItem extends StatelessWidget {
  const ShareLocationMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          Icons.share,
          color: theme.colorScheme.primaryVariant,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          'Share',
          style: TextStyle(
            color: theme.colorScheme.primaryVariant,
          ),
        ),
      ],
    );
  }
}
