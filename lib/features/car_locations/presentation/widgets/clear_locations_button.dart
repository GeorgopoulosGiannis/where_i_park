import 'package:flutter/material.dart';

class ClearLocationsButton extends StatelessWidget {
  const ClearLocationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          //  context.read<Cars>().add(ClearAll(widget.car));
        },
        icon: const Icon(
          Icons.delete_forever_rounded,
        ));
  }
}
