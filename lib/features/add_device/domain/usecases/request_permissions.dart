import 'package:injectable/injectable.dart';
import 'package:where_i_park/services/location_manager.dart';

@lazySingleton
class RequestPermissions {
  final LocationManager mgr;

  RequestPermissions(this.mgr);

  Future<bool> call() {
    return mgr.getPermissionForAutomatic();
  }
}
