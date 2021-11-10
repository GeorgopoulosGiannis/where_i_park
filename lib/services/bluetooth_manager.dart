import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/features/cars/data/repositories/car_repository_impl.dart';
import 'package:where_i_park/features/cars/presentation/bloc/cars_bloc.dart';
import '../features/bonded_devices/domain/repository/bonded_devices_repository.dart';
import 'package:where_i_park/features/cars/domain/repositories/car_repository.dart';

import 'injector.dart';
import 'location_manager.dart';

const connectedDevice = 'CONNECTED_DEVICE';

@singleton
class BluetoothManager {
  static Future<void> init() async {
    await BluetoothEvents.initialize();
    await BluetoothEvents.setBluetoothEventCallback(_bluetoothCallback);
  }

  static Future<void> _bluetoothCallback(Map<String, dynamic> evt) async {
    final action = evt['ACTION'];
    if (action == 'android.bluetooth.device.action.ACL_CONNECTED') {
      _handleDeviceConnected(evt['DEVICE_ADDRESS']);
    } else if (action == 'android.bluetooth.device.action.ACL_DISCONNECTED') {
      _handleDeviceDisconnected(evt['DEVICE_ADDRESS']);
    }
  }

  Future<Map<String, dynamic>> getPairedDevices() async {
    return await BluetoothEvents.getBondedDevices();
  }

  static Future<void> _handleDeviceConnected(String address) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(connectedDevice, address);
    if (sl.isRegistered<CarsBloc>()) {
      sl<CarsBloc>().add(LoadConnectedDevice());
    }
  }

  static Future<void> _handleDeviceDisconnected(String address) async {
    final _prefs = await SharedPreferences.getInstance();

    await _prefs.remove(connectedDevice);

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
    final curLocation = await locationManager.getCurrentLocation();
    await carsRepo.appendToCarLocations(
      savedCar,
      curLocation,
    );
     if (sl.isRegistered<CarsBloc>()) {
      sl<CarsBloc>().add(LoadConnectedDevice());
    }
  }
}
