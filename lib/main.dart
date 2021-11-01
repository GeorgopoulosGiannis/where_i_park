import 'dart:async';

import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import 'features/home/presentation/home_screen.dart';

void main() async {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Wakelock.enable();
    await BluetoothEvents.initialize();
    await BluetoothEvents.setBluetoothEventCallback(_bluetoothCallback);
    runApp(const MyApp());
  });
}

Future<void> _bluetoothCallback(Map<String, dynamic> evt) async {
  print(evt);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Where did i park?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(
        child: HomeScreen(),
      ),
    );
  }
}
