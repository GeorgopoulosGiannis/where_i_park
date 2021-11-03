import 'package:either_dart/either.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/bonded_devices/domain/entities/bluetooth_device.dart';

abstract class BondedDevicesRepository {
  Future<Either<Failure, List<BluetoothDevice>>> getBondedDevices();
}
