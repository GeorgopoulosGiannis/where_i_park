import 'dart:developer' as developer;

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:where_i_park/core/constants.dart';
import 'package:where_i_park/core/data/models/bluetooth_device_model.dart';
import 'package:where_i_park/core/data/models/car_location_model.dart';
import 'package:where_i_park/features/add_device/domain/entities/bluetooth_device.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/services/storage_manager.dart';

class _Constants {
  static const lastLocation = 'LAST_lOCATION';
}

@lazySingleton
class LocationManager {
  final StorageManager mgr;

  LocationManager(this.mgr);

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<CarLocation?> getLastLocation() async {
    final Map<String, dynamic>? savedEncoded =
        await mgr.getValueByKey(_Constants.lastLocation);

    if (savedEncoded != null) {
      return CarLocationModel.fromJson(savedEncoded);
    }
  }

  Stream<Position> getLocationUpdates() {
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
      final locToJson = loc.toJson();
      await mgr.saveValue(_Constants.lastLocation, locToJson);

      final saved = await mgr.getListByKey(Constants.carLocations);
      saved.add(locToJson);
      return await mgr.setListByKey(Constants.carLocations, saved);
    } catch (e) {
      developer.log(e.toString());
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
