import 'package:injectable/injectable.dart';
import 'package:where_i_park/services/location_manager.dart';

@lazySingleton
class HasPermissions{
  final LocationManager mgr;

  HasPermissions(this.mgr);

  Future<bool> call(){
    return mgr.hasPermissionForAutomatic();
  }
}