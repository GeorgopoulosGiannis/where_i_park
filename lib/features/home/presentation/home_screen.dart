import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/bonded_devices/presentation/bloc/bonded_devices_bloc.dart';
import 'package:where_i_park/features/bonded_devices/presentation/bonded_devices_screen.dart';
import 'package:where_i_park/features/cars/presentation/widgets/cars_list.dart';
import 'package:where_i_park/features/cars/presentation/widgets/cars_title.dart';
import 'package:where_i_park/services/injector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Future<void> _readSavedCars() async {
  //   final encodedCars = sharedPrefs.getString(savedCarsKey);
  //   if (encodedCars != null) {
  //     cars = json.decode(encodedCars);
  //     setState(() {});
  //   }
  // }

  // Future<void> _addToSavedCars(MapEntry<String, dynamic> entry) async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   final encodedCars = sharedPrefs.getString(savedCarsKey);
  //   final Map<String, dynamic> carsMap =
  //       encodedCars != null ? json.decode(encodedCars) : <String, dynamic>{};
  //   carsMap[entry.key] = entry.value;
  //   sharedPrefs.setString(savedCarsKey, json.encode(carsMap));
  //   cars = carsMap;
  //   setState(() {});
  // }

  // Future<void> _removeFromSavedCars(String key) async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   final encodedCars = sharedPrefs.getString(savedCarsKey);
  //   final Map<String, dynamic> carsMap =
  //       encodedCars != null ? json.decode(encodedCars) : <String, dynamic>{};
  //   carsMap.remove(key);
  //   sharedPrefs.setString(savedCarsKey, json.encode(carsMap));
  //   cars = carsMap;
  //   setState(() {});
  // }

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
          final newEntry =
              await Navigator.of(context).push<MapEntry<String, dynamic>?>(
            MaterialPageRoute(
              builder: (context) =>  BlocProvider(
                create: (context) => sl<BondedDevicesBloc>(),
                child:const BondedDevicesScreen(),
              ),
            ),
          );
          if (newEntry != null) {
            //_addToSavedCars(newEntry);
          }
        },
        label: const Text('Add a new car'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
