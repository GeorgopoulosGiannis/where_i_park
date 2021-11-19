import 'dart:isolate';
import 'package:background_location/background_location.dart';

import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/constants.dart';
import 'package:where_i_park/core/presentation/bloc/app_bloc.dart';
import 'package:where_i_park/features/car_locations/domain/entities/car_location.dart';
import 'package:where_i_park/features/cars/domain/repositories/car_locations_repository.dart';
import '../features/cars/domain/repositories/car_repository.dart';

import 'injector.dart';
import 'location_manager.dart';
import 'notification_manager.dart';

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
    print('_handleDeviceDisconnected start');
    final _prefs = await SharedPreferences.getInstance();
    print('_handleDeviceDisconnected got prefs');
    await _prefs.remove(Constants.connectedDevice);
    print('_handleDeviceDisconnected removed connected device');
    final isRegistered = sl.isRegistered<CarRepository>();

    if (!isRegistered) {
      print('_handleDeviceDisconnected before configureDeps');
      await configureDependencies();
      print('_handleDeviceDisconnected after configureDeps');
    }
    final carsRepo = sl<CarRepository>();
    print('_handleDeviceDisconnected search car');
    final savedCar = carsRepo.findInSaved(address);

    if (savedCar == null) {
      print('_handleDeviceDisconnected car was null');
      return;
    }
    print('_handleDeviceDisconnected car found');
    final locationManager = sl<LocationManager>();

    final position = await Geolocator.getCurrentPosition();
    print('position $position');

    final placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print('_handleDeviceDisconnected found placemark');
    final carLocationsRepo = sl<CarLocationsRepository>();
    print('_handleDeviceDisconnected before pushToCarLocations');
    await carLocationsRepo.pushToCarLocations(
      savedCar,
      CarLocation(
        position: position,
        placemark: placemark.first,
      ),
    );

    print('_handleDeviceDisconnected after pushToCarLocations');
    final notificationManager = sl<NotificationManager>();
    print('_handleDeviceDisconnected before NotificationManager.initialize()');
    await NotificationManager.initialize();
    print('_handleDeviceDisconnected after NotificationManager.initialize()');
    notificationManager.showNotification(
      id: 123,
      title: 'Car Location added!',
      body: savedCar.name,
    );
  }
}
