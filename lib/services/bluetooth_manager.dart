import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
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
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(Constants.connectedDevice, address);
  }

  static Future<void> _handleDeviceDisconnected(String address) async {
    final _prefs = await SharedPreferences.getInstance();

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
    final locationManager = sl<LocationManager>();
    final position = await locationManager.getCurrentLocation();
    final placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final carLocationsRepo = sl<CarLocationsRepository>();
    await carLocationsRepo.pushToCarLocations(
      savedCar,
      CarLocation(
        position: position,
        placemark: placemark.first,
      ),
    );
    final notificationManager = sl<NotificationManager>();
    await NotificationManager.initialize();
    notificationManager.showNotification(
      id: 123,
      title: 'Car Location added!',
      body: savedCar.name,
    );
  }
}
