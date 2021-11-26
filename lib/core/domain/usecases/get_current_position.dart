import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/services/location_manager.dart';

@lazySingleton
class GetCurrentPosition {
  final LocationManager mgr;

  GetCurrentPosition(this.mgr);

  Future<Position> call() async {
    return mgr.getCurrentPosition();
  }
}
