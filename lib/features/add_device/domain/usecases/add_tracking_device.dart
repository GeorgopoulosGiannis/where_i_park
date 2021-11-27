import 'package:injectable/injectable.dart';
import 'package:where_i_park/features/add_device/domain/entities/bluetooth_device.dart';
import 'package:where_i_park/services/storage_manager.dart';

@lazySingleton
class AddTrackingDevice {
  final StorageManager mgr;

  AddTrackingDevice(this.mgr);

  Future<bool> call(BluetoothDevice dev) async {
    return mgr.addDeviceForTracking(dev);
  }
}
