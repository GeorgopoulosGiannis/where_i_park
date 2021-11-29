import 'package:injectable/injectable.dart';

import 'package:where_i_park/services/location_manager.dart';

@lazySingleton
class SaveCurrentLocation {
  final LocationManager mgr;

  SaveCurrentLocation(this.mgr);
  Future<bool> call() async {
    bool hasPerm = await mgr.hasPermissionForManual();
    if (!hasPerm && !await mgr.getPermissionForManual()) {
      return false;
    }

    return await mgr.saveCurrentLocation();
  }
}
