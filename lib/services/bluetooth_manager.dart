import 'dart:convert';
import 'dart:isolate';

import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/constants.dart';

import 'injector.dart';
import 'location_manager.dart';
import 'notification_manager.dart';

abstract class _Constants {
  static const connectedEvent = 'android.bluetooth.device.action.ACL_CONNECTED';
  static const disconnectedEvent =
      'android.bluetooth.device.action.ACL_DISCONNECTED';
}

@singleton
class BluetoothManager {
  BluetoothManager() {
    bluetoothNotifierChannel.setMethodCallHandler((call) async {
      if (call.method == _Constants.connectedEvent) {
      } else if (call.method == _Constants.disconnectedEvent) {
        return {
          "body": "location saved!",
          "title": call.arguments["DEVICE_NAME"]
        };
      }
    });
  }
  static const bluetoothNotifierChannel = MethodChannel('BLUETOOTH_NOTIFIER');

  static Future<void> init() async {
    await BluetoothEvents.initialize();
    await BluetoothEvents.setBluetoothEventCallback(_bluetoothCallback);
  }

  static Future<void> _bluetoothCallback(Map<String, dynamic> evt) async {
    final action = evt['ACTION'];
    if (action == _Constants.connectedEvent) {
      _handleDeviceConnected(evt['DEVICE_ADDRESS']);
    } else if (action == _Constants.disconnectedEvent) {
      await _handleDeviceDisconnected(evt['DEVICE_ADDRESS']);
    }
  }

  Future<Map<String, dynamic>> getPairedDevices() async {
    return await BluetoothEvents.getBondedDevices();
  }

  static Future<void> _handleDeviceConnected(String address) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(Constants.connectedDevice, address);
  }

  static Future<void> _handleDeviceDisconnected(String address) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.reload();
    await _prefs.remove(Constants.connectedDevice);

    // if (!isRegistered) {
    //   await configureDependencies();
    // }

    // if (savedCar == null) {
    //   return;
    // }
    // if (savedCar.tracking == TrackMethod.automatic) {
    //   //await sl<LocationManager>().saveCarLocation(savedCar);
    // } else {
    //   await NotificationManager.initialize();
    //   NotificationManager.showNotification(
    //     id: 123,
    //     title: 'Tap to save location!!',
    //     body: savedCar.name,
    //     payload: json.encode((savedCar as CarModel).toJson()),
    //   );
  }
}
