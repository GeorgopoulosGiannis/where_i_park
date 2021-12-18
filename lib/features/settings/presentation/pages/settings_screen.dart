import 'package:flutter/material.dart';
import 'package:where_i_park/features/settings/presentation/widgets/settings_switch_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: const [
            SettingsSwitchItem(),
          ],
        ),
      ),
    );
  }
}
