import 'dart:async';

import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:where_i_park/core/data/models/bluetooth_device_model.dart';
import 'package:where_i_park/services/injector.dart';
import 'package:where_i_park/services/location_manager.dart';
import 'package:where_i_park/services/storage_manager.dart';

abstract class _Constants {
  static const connectedEvent = 'android.bluetooth.device.action.ACL_CONNECTED';
  static const disconnectedEvent =
      'android.bluetooth.device.action.ACL_DISCONNECTED';
}

@singleton
class BluetoothManager {
  final connectedDeviceSubject = BehaviorSubject.seeded('');

  //#region Foreground
  static const bluetoothNotifierChannel = MethodChannel('BLUETOOTH_NOTIFIER');
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

  //#endregion

  //#region Background

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
    final isRegistered = sl.isRegistered<StorageManager>();
    if (!isRegistered) {
      await configureDependencies();
    }
    final storage = sl<StorageManager>();
    await storage.setConnected(address);
  }

  static Future<void> _handleDeviceDisconnectedBackground(
    String address,
  ) async {
    final isRegistered = sl.isRegistered<StorageManager>();
    if (!isRegistered) {
      await configureDependencies();
    }
    final storage = sl<StorageManager>();
    await storage.removeConnected();

    final tracking = storage.getTrackingDevices();
    BluetoothDeviceModel? saved;
    for (var d in tracking) {
      if (d.address == address) {
        saved = d;
      }
    }
    if (saved == null) {
      return;
    }
    await sl<LocationManager>().saveCurrentLocation(device: saved);
  }
}
