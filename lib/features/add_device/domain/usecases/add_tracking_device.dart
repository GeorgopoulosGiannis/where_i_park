import 'package:injectable/injectable.dart';
import 'package:where_i_park/features/add_device/domain/entities/bluetooth_device.dart';
import 'package:where_i_park/services/location_manager.dart';
import 'package:where_i_park/services/storage_manager.dart';

@lazySingleton
class AddTrackingDevice {
  final StorageManager mgr;
  final LocationManager locMgr;

  AddTrackingDevice(this.mgr, this.locMgr);

  Future<bool> call(BluetoothDevice dev) async {
    bool hasPermission = await locMgr.hasPermissionForAutomatic();
    if (!hasPermission) {
      hasPermission = await locMgr.getPermissionForAutomatic();
    }
    if (!hasPermission) {
      return false;
    }
    return mgr.addDeviceForTracking(dev);
  }
}
