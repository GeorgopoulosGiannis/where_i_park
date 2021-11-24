import 'package:where_i_park/features/bluetooth_tracker/add_car_stepper/presentation/bloc/add_car_stepper_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/bonded_devices/domain/entities/bluetooth_device.dart';

class Car extends BluetoothDevice {
  final TrackMethod tracking;
  const Car({
    required this.tracking,
    required String name,
    required String address,
  }) : super(
          name: name,
          address: address,
        );

  @override
  List<Object?> get props => [
        name,
        address,
        
      ];
}
