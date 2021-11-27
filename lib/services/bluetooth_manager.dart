import 'dart:async';

import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/constants.dart';

abstract class _Constants {
  static const connectedEvent = 'android.bluetooth.device.action.ACL_CONNECTED';
  static const disconnectedEvent =
      'android.bluetooth.device.action.ACL_DISCONNECTED';
}

@singleton
class BluetoothManager {
  final connectedDeviceSubject = BehaviorSubject.seeded('');

  BluetoothManager() {
    bluetoothNotifierChannel.setMethodCallHandler(
      (call) async {
        if (call.method == _Constants.connectedEvent) {
          handleDeviceConnectedForeground(call.arguments);
        } else if (call.method == _Constants.disconnectedEvent) {
          handleDeviceDisconnectedForeground();
        }
      },
    );
  }
  void handleDeviceConnectedForeground(String address) {
    connectedDeviceSubject.add(address);
  }

  void handleDeviceDisconnectedForeground() {
    connectedDeviceSubject.add(' ');
  }

  static const bluetoothNotifierChannel = MethodChannel('BLUETOOTH_NOTIFIER');

  static Future<void> init() async {
    await BluetoothEvents.initialize();
    await BluetoothEvents.setBluetoothEventCallback(_bluetoothCallback);
  }

  static Future<void> _bluetoothCallback(Map<String, dynamic> evt) async {
    final action = evt['ACTION'];
    if (action == _Constants.connectedEvent) {
      _handleDeviceConnectedBackground(evt['DEVICE_ADDRESS']);
    } else if (action == _Constants.disconnectedEvent) {
      await _handleDeviceDisconnectedBackground(evt['DEVICE_ADDRESS']);
    }
  }

  Future<Map<String, dynamic>> getPairedDevices() async {
    return await BluetoothEvents.getBondedDevices();
  }

  static Future<void> _handleDeviceConnectedBackground(String address) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(Constants.connectedDevice, address);
  }

  static Future<void> _handleDeviceDisconnectedBackground(
      String address) async {
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
