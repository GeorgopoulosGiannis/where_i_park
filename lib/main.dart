import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wakelock/wakelock.dart';

import 'services/injector.dart';
import 'services/bluetooth_manager.dart';

import 'features/cars/presentation/bloc/cars_bloc.dart';
import 'features/bonded_devices/presentation/bloc/bonded_devices_bloc.dart';

import 'features/home/presentation/home_screen.dart';

void main() async {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Wakelock.enable();
    await Geolocator.requestPermission();
    await configureDependencies();
    await BluetoothManager.init();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CarsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<BondedDevicesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Where did i park?',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
