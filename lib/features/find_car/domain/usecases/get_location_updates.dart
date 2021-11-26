import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/services/location_manager.dart';

@lazySingleton
class GetLocationUpdates {
  final LocationManager mgr;

  GetLocationUpdates(this.mgr);

  Stream<Position> call() {
    return mgr.getLocationUpdates();
  }
}
