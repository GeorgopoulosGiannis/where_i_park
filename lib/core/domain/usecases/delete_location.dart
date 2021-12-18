import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';

import 'package:where_i_park/services/location_manager.dart';

@lazySingleton
class DeleteLocations {
  final LocationManager mgr;

  DeleteLocations(this.mgr);

  Future<bool?> call(List<CarLocation> locations) async {
    bool result = false;
    for (var l in locations) {
      result = await mgr.deleteLocation(l);
    }
    return result;
  }
}
