import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/bluetooth_tracker/bonded_devices/domain/entities/bluetooth_device.dart';
import 'package:where_i_park/features/bluetooth_tracker/bonded_devices/domain/repository/bonded_devices_repository.dart';

@lazySingleton
class LoadBondedDevices extends UseCase<List<BluetoothDevice>, NoParams> {
  final BondedDevicesRepository repo;

  LoadBondedDevices(this.repo);
  @override
  Future<Either<Failure, List<BluetoothDevice>>> call(NoParams params) {
    return repo.getBondedDevices();
  }
}
