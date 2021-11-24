import 'dart:convert';
import 'dart:isolate';

import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/constants.dart';
import 'package:where_i_park/core/presentation/bloc/app_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/add_car_stepper/presentation/bloc/add_car_stepper_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/entities/car_location.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/data/models/car_model.dart';

import 'package:where_i_park/features/bluetooth_tracker/cars/domain/repositories/car_locations_repository.dart';
import '../cars/domain/repositories/car_repository.dart';

import '../../../services/injector.dart';
import '../../../services/location_manager.dart';
import '../../../services/notification_manager.dart';

@singleton
class BluetoothManager {
  final AppBloc appBloc;
  BluetoothManager(this.appBloc) {
    bluetoothNotifierChannel.setMethodCallHandler((call) async {
      if (call.method == 'android.bluetooth.device.action.ACL_CONNECTED') {
        appBloc.add(DeviceConnected(call.arguments));
      } else if (call.method ==
          'android.bluetooth.device.action.ACL_DISCONNECTED') {
        appBloc.add(DeviceDisconnected());
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
    final int isolateId = Isolate.current.hashCode;
    print('isolateId  $isolateId ');
    print('inside bluetooth callback');
    final action = evt['ACTION'];
    if (action == 'android.bluetooth.device.action.ACL_CONNECTED') {
      _handleDeviceConnected(evt['DEVICE_ADDRESS']);
    } else if (action == 'android.bluetooth.device.action.ACL_DISCONNECTED') {
      await _handleDeviceDisconnected(evt['DEVICE_ADDRESS']);
    }
  }

  Future<Map<String, dynamic>> getPairedDevices() async {
    return await BluetoothEvents.getBondedDevices();
  }

  static Future<void> _handleDeviceConnected(String address) async {
    print('_handleDeviceConnected start');
    final _prefs = await SharedPreferences.getInstance();
    print('_handleDeviceConnected got prefs');
    await _prefs.setString(Constants.connectedDevice, address);
    print('_handleDeviceConnected finished');
  }

  static Future<void> _handleDeviceDisconnected(String address) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.reload();
    await _prefs.remove(Constants.connectedDevice);
    
    final isRegistered = sl.isRegistered<CarRepository>();

    if (!isRegistered) {
      await configureDependencies();
    }
    final carsRepo = sl<CarRepository>();
    final savedCar = carsRepo.findInSaved(address);

    if (savedCar == null) {
      return;
    }
    if (savedCar.tracking == TrackMethod.automatic) {
      await sl<LocationManager>().saveCarLocation(savedCar);
    } else {
      await NotificationManager.initialize();
      NotificationManager.showNotification(
        id: 123,
        title: 'Car Disconnected tap here to save Location!!',
        body: savedCar.name,
        payload: json.encode((savedCar as CarModel).toJson()),
      );
    }
  }
}
