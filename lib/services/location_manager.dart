import 'dart:convert';


import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/data/models/bluetooth_device_model.dart';
import 'package:where_i_park/core/data/models/car_location_model.dart';
import 'package:where_i_park/features/add_device/domain/entities/bluetooth_device.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';

class _Constants {
  static const lastLocation = 'LAST_lOCATION';
}

@lazySingleton
class LocationManager {
  final SharedPreferences _prefs;

  LocationManager(this._prefs);

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<CarLocation?> getLastLocation() async {
    final saved = _prefs.getString(_Constants.lastLocation);
    if (saved != null) {
      return CarLocationModel.fromJson(json.decode(saved));
    }
  }

  Stream<Position> getLocationUpdates()  {
   return Geolocator.getPositionStream();
  }

  Future<bool> saveCurrentLocation({
    BluetoothDevice? device,
  }) async {
    try {
      final position = await getCurrentPosition();
      final loc = CarLocationModel(
        positionModel: position,
        deviceModel:
            device != null ? BluetoothDeviceModel.fromDevice(device) : null,
      );
      return await _prefs.setString(
        _Constants.lastLocation,
        json.encode(loc),
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> hasPermissionForAutomatic() async {
    final perm =
        await Permission.locationAlways.status == PermissionStatus.granted;
    return perm;
  }

  Future<bool> getPermissionForAutomatic() async {
    if (await hasPermissionForAutomatic()) {
      return true;
    }
    bool hasManual = await hasPermissionForManual();
    if (!hasManual) {
      hasManual = await getPermissionForManual();
    }
    if (!hasManual) {
      return false;
    }
    // cant request always if we dont have atleast when in use
    PermissionStatus alwaysPermission =
        await Permission.locationAlways.request();
    if (alwaysPermission == PermissionStatus.permanentlyDenied) {
      await AppSettings.openLocationSettings();
      alwaysPermission = await Permission.locationAlways.request();
    }
    return alwaysPermission.isGranted;
  }

  Future<bool> hasPermissionForManual() async {
    return await Permission.locationWhenInUse.status ==
        PermissionStatus.granted;
  }

  Future<bool> getPermissionForManual() async {
    if (await hasPermissionForManual()) {
      return true;
    }
    final whenInUse = await Permission.locationWhenInUse.request();
    return whenInUse.isGranted;
  }
}
