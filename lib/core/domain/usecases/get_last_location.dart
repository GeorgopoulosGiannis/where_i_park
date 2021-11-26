import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/services/location_manager.dart';

@lazySingleton
class GetLastLocation {
  final LocationManager mgr;

  GetLastLocation(this.mgr);

  Future<CarLocation?> call() async {
    return mgr.getLastLocation();
  }
}
