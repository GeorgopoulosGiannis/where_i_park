import 'package:flutter/material.dart';

class CarsTitle extends StatelessWidget {
  const CarsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Cars being watched',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
