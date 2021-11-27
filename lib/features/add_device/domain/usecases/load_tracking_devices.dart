import 'dart:developer' as developer;
import 'package:injectable/injectable.dart';
import 'package:where_i_park/services/storage_manager.dart';

import '../entities/bluetooth_device.dart';

@lazySingleton
class LoadTrackingDevices {
  final StorageManager mgr;

  LoadTrackingDevices(this.mgr);

  Future<List<BluetoothDevice>> call() async {
    try {
      return mgr.getTrackingDevices();
    } catch (e) {
      developer.log(e.toString());
      return [];
    }
  }
}
