import 'package:flutter/material.dart';

class SettingsSwitchItem extends StatefulWidget {
  const SettingsSwitchItem({Key? key}) : super(key: key);

  @override
  State<SettingsSwitchItem> createState() => _SettingsSwitchItemState();
}

class _SettingsSwitchItemState extends State<SettingsSwitchItem> {
  late final theme = Theme.of(context);
  bool val = false;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        'Show notification on background location save',
        style: theme.textTheme.subtitle1,
      ),
      value: val,
      activeColor: Theme.of(context).colorScheme.primary,
      onChanged: (newVal) {
        val = newVal;
        setState(() {});
      },
    );
  }
}
