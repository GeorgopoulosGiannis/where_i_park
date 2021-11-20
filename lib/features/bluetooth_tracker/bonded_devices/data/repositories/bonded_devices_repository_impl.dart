import 'package:injectable/injectable.dart';
import 'package:where_i_park/features/bluetooth_tracker/bonded_devices/domain/entities/bluetooth_device.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';
import 'package:where_i_park/features/bluetooth_tracker/bonded_devices/domain/repository/bonded_devices_repository.dart';
import 'package:where_i_park/features/bluetooth_tracker/services/bluetooth_manager.dart';

@LazySingleton(as: BondedDevicesRepository)
class BondedDevicesRepositoryImpl extends BondedDevicesRepository {
  final BluetoothManager bm;

  BondedDevicesRepositoryImpl(this.bm);
  @override
  Future<Either<Failure, List<BluetoothDevice>>> getBondedDevices() async {
    try {
      final bondedMap = await bm.getPairedDevices();
      final result = <BluetoothDevice>[];
      for (var entry in bondedMap.entries) {
        result.add(
          BluetoothDevice(
            address: entry.key,
            name: entry.value['name'],
          ),
        );
      }
      return Right(result);
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
