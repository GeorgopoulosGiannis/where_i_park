import 'dart:developer' as developer;
import 'package:injectable/injectable.dart';

import 'package:where_i_park/services/bluetooth_manager.dart';

import '../entities/bluetooth_device.dart';

@lazySingleton
class LoadDevices {
  final BluetoothManager mgr;

  LoadDevices(this.mgr);

  Future<List<BluetoothDevice>> call() async {
    try {
      final devices = await mgr.getPairedDevices();
      final result = <BluetoothDevice>[];
      for (var entry in devices.entries) {
        result.add(
          BluetoothDevice(
            address: entry.key,
            name: entry.value['name'],
          ),
        );
      }
      return result;
    } catch (e) {
      developer.log(e.toString());
      return [];
    }
  }
}
