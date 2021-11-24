import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/entities/car_location.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/data/models/car_model.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/repositories/car_locations_repository.dart';
import 'package:where_i_park/services/injector.dart';

@lazySingleton
class LocationManager {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> getCurrentLocation() async {
    // return Position(
    //   longitude: 23.73337218401643,
    //   latitude: 37.907393091203936,
    //   timestamp: DateTime.now(),
    //   accuracy: 1,
    //   altitude: 0.0,
    //   heading: 0.0,
    //   speed: 0.0,
    //   speedAccuracy: 0.0,
    // );
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
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

  Future<void> saveCarLocation(Car car) async {
    final position = await getCurrentLocation();
    final placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final carLocationsRepo = sl<CarLocationsRepository>();
    await carLocationsRepo.pushToCarLocations(
      car,
      CarLocation(
        position: position,
        placemark: placemark.first,
      ),
    );
  }
}
