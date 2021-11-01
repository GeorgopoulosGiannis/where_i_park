import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/features/bonded_devices/presentation/bonded_devices_screen.dart';

const sharedPrefsKey = 'SHARED_PREFS_KEY';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var cars = <String, dynamic>{};

  int selectedIndex = -1;
  @override
  void initState() {
    _readSavedCars();
    super.initState();
  }

  Future<void> _readSavedCars() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final encodedCars = sharedPrefs.getString(sharedPrefsKey);
    if (encodedCars != null) {
      cars = json.decode(encodedCars);
      setState(() {});
    }
  }

  Future<void> _addToSavedCars(MapEntry<String, dynamic> entry) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final encodedCars = sharedPrefs.getString(sharedPrefsKey);
    final Map<String, dynamic> carsMap =
        encodedCars != null ? json.decode(encodedCars) : <String, dynamic>{};
    carsMap[entry.key] = entry.value;
    sharedPrefs.setString(sharedPrefsKey, json.encode(carsMap));
    cars = carsMap;
    setState(() {});
  }

  Future<void> _removeFromSavedCars(String key) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final encodedCars = sharedPrefs.getString(sharedPrefsKey);
    final Map<String, dynamic> carsMap =
        encodedCars != null ? json.decode(encodedCars) : <String, dynamic>{};
    carsMap.remove(key);
    sharedPrefs.setString(sharedPrefsKey, json.encode(carsMap));
    cars = carsMap;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where did i Park?'),
        actions: [
          if (selectedIndex != -1)
            IconButton(
              onPressed: () {
                _removeFromSavedCars(cars.keys.elementAt(selectedIndex));
                
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Cars',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (cars.isEmpty)
            const Center(
              child: Text(
                'No Cars have been added yet',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          Flexible(
            child: ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final item = cars.entries.elementAt(index);
                final title = item.value['name'] != item.value['alias']
                    ? '${item.value['name']} ( ${item.value['alias']} )'
                    : item.value['name'];
                return ListTile(
                  title: Text(title),
                  subtitle: Text(item.key),
                  tileColor: _getTileColor(index),
                  onTap: () {
                    if (selectedIndex == index) {
                      selectedIndex = -1;
                    } else {
                      selectedIndex = index;
                    }

                    setState(() {});
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newEntry =
              await Navigator.of(context).push<MapEntry<String, dynamic>?>(
            MaterialPageRoute(
              builder: (context) => const BondedDevicesScreen(),
            ),
          );
          if (newEntry != null) {
            _addToSavedCars(newEntry);
          }
        },
        label: const Text('Add a new car'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Color? _getTileColor(int index) {
    if (index == selectedIndex) {
      return Theme.of(context).colorScheme.primary;
    }
    return index % 2 != 0 ? Colors.grey[200] : null;
  }
}
