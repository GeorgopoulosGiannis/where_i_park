import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class LocationManager {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<bool> hasPermissionForAutomatic() async {
    return await Permission.locationAlways.status != PermissionStatus.granted;
  }

  Future<bool> getPermissionForAutomatic() async {
    bool hasManual = await hasPermissionForManual();
    if (!hasManual) {
      hasManual = await getPermissionForManual();
    }
    if (!hasManual) {
      return false;
    }
    // cant request always if we dont have atleast when in use
    final alwaysPermission = await Permission.locationAlways.request();
    return alwaysPermission.isGranted;
  }

  Future<bool> hasPermissionForManual() async {
    return await Permission.locationWhenInUse.status !=
        PermissionStatus.granted;
  }

  Future<bool> getPermissionForManual() async {
    final whenInUse = await Permission.locationWhenInUse.request();
    return whenInUse.isGranted;
  }
}
