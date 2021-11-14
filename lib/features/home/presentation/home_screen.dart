import 'package:flutter/material.dart';

import 'package:where_i_park/features/bonded_devices/presentation/bonded_devices_screen.dart';
import 'package:where_i_park/features/cars/presentation/widgets/cars_list.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where did i Park?'),
        actions: [
          IconButton(
            onPressed: () {
              //_removeFromSavedCars(cars.keys.elementAt(selectedIndex));
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: const CarsList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BondedDevicesScreen(),
            ),
          );
        },
        label: const Text('Add a new car'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
