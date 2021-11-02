import 'dart:async';
import 'dart:convert';

import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

import 'features/home/presentation/home_screen.dart';
import 'services/notification_manager.dart';

void main() async {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Wakelock.enable();
    await BluetoothEvents.initialize();
    await BluetoothEvents.
    setBluetoothEventCallback(_bluetoothCallback);
    await NotificationManager.initialize();
    runApp(const MyApp());
  });
}

Future<void> _bluetoothCallback(Map<String, dynamic> evt) async {
  final action = evt['ACTION'];
  if (action == 'android.bluetooth.device.action.ACL_CONNECTED') {
    _handleDeviceConnected(evt['DEVICE_ADDRESS']);
  } else if (action == 'android.bluetooth.device.action.ACL_DISCONNECTED') {
    _handleDeviceDisconnected(evt['DEVICE_ADDRESS']);
  }
}

Future<void> _handleDeviceConnected(String address) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final encoded = sharedPrefs.getString(savedCarsKey);
  if (encoded != null) {
    final Map<String, dynamic> savedCars = json.decode(encoded);
    for (var entry in savedCars.entries) {
      if(entry.key == address){
        final newVal = {...entry.value as Map<String,dynamic>,'CONNECTED':true};
        
        savedCars[entry.key] = newVal;
        sharedPrefs.setString(savedCarsKey, json.encode(savedCars));
      }
    }
  }
}

Future<void> _handleDeviceDisconnected(String address) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final encoded = sharedPrefs.getString(savedCarsKey);
  if (encoded != null) {
    final Map<String, dynamic> savedCars = json.decode(encoded);
    for (var entry in savedCars.entries) {
      if(entry.key == address){
        NotificationManager.showNotification();
      }
    }
  }
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
