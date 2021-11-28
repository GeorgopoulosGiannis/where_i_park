import 'dart:developer' as developer;
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/data/models/bluetooth_device_model.dart';
import 'package:where_i_park/features/add_device/domain/entities/bluetooth_device.dart';

abstract class _Constants {
  static const trackingDevicesKey = 'TRACKING_DEVICES';
  static const connectedDevice = 'CONNECTED_DEVICE';
}

@singleton
class StorageManager {
  final SharedPreferences _prefs;

  StorageManager(this._prefs);

  List<BluetoothDeviceModel> getTrackingDevices() {
    try {
      final str = _prefs.getString(_Constants.trackingDevicesKey);
      if (str == null) {
        return [];
      }
      List<dynamic> _list = json.decode(str);
      return _list.map((item) => BluetoothDeviceModel.fromJson(item)).toList();
    } catch (e) {
      developer.log(e.toString());
      return [];
    }
  }
  

  Future<bool> addDeviceForTracking(BluetoothDevice dev) async {
    try {
      final trackingDevices = getTrackingDevices();
      var index = trackingDevices.indexWhere(
        (d) => d.address == dev.address,
      );
      trackingDevices.insert(
        index == -1 ? 0 : index,
        BluetoothDeviceModel.fromDevice(dev),
      );
      return await _prefs.setString(
        _Constants.trackingDevicesKey,
        json.encode(
          trackingDevices
              .map(
                (e) => e.toJson(),
              )
              .toList(
                growable: false,
              ),
        ),
      );
    } catch (e) {
      developer.log(e.toString());
      return false;
    }
  }

  Future<bool> removeDeviceFromTracking(BluetoothDevice dev) async {
    try {
      final trackingDevices = getTrackingDevices();
      var index = trackingDevices.indexWhere(
        (d) => d.address == dev.address,
      );
      if (index == -1) {
        return false;
      }
      trackingDevices.removeAt(index);
      return await _prefs.setString(
        _Constants.trackingDevicesKey,
        json.encode(
          trackingDevices
              .map(
                (e) => e.toJson(),
              )
              .toList(
                growable: false,
              ),
        ),
      );
    } catch (e) {
      developer.log(e.toString());
      return false;
    }
  }

  Future<void> setConnected(String address) async {
    await _prefs.reload();
    await _prefs.setString(_Constants.connectedDevice, address);
  }

  Future<void> removeConnected() async {
    await _prefs.reload();
    await _prefs.remove(_Constants.connectedDevice);
  }
}
