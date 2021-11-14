

import 'package:where_i_park/features/bonded_devices/domain/entities/bluetooth_device.dart';

class Car extends BluetoothDevice {
  const Car({
    required String name,
    required String address,
  }) : super(
          name: name,
          address: address,
        );
}
