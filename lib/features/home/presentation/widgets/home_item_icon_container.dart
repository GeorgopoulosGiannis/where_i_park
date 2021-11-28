import 'package:flutter/material.dart';

class HomeItemIconContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  const HomeItemIconContainer({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? theme.colorScheme.primaryVariant,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 80,
            width: 80,
            child: child,
          ),
        ),
      ),
    );
  }
}
