import 'package:flutter/material.dart';

class PageActionsButton extends StatelessWidget {
  const PageActionsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton(
      color: theme.backgroundColor,
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            child: ShowAllLocationsSwitch(),
          ),
        ];
      },
    );
  }
}

class ShowAllLocationsSwitch extends StatefulWidget {
  const ShowAllLocationsSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowAllLocationsSwitch> createState() => _ShowAllLocationsSwitchState();
}

class _ShowAllLocationsSwitchState extends State<ShowAllLocationsSwitch> {
  late final theme = Theme.of(context);
  bool _val = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: theme.colorScheme.primaryVariant,
      title: Text(
        'Show all locations',
        style: theme.textTheme.subtitle1?.copyWith(
          color: theme.colorScheme.primaryVariant,
        ),
      ),
      value: _val,
      onChanged: (val) {
        setState(() {
          _val = val;
        });
      },
    );
  }
}
