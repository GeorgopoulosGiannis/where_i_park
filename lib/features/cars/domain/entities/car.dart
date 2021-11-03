import 'package:equatable/equatable.dart';
import 'package:where_i_park/features/bonded_devices/domain/entities/bluetooth_device.dart';

class Car extends BluetoothDevice {
  const Car({
    required name,
    required address,
    required isConnected,
  }) : super(
          name: name,
          address: address,
          isConnected: isConnected,
        );
}
