part of 'add_device_bloc.dart';

class AddDeviceState extends Equatable {
  final List<BluetoothDevice> devices;
  final List<BluetoothDevice> alreadyAddedDevices;
  final String? connectedDeviceAddress;

  const AddDeviceState({
    this.devices = const [],
    this.alreadyAddedDevices = const [],
    this.connectedDeviceAddress,
  });

  AddDeviceState copyWith({
    List<BluetoothDevice>? devices,
    List<BluetoothDevice>? alreadyAddedDevices,
    String? connectedDeviceAddress,
  }) =>
      AddDeviceState(
        connectedDeviceAddress:
            connectedDeviceAddress ?? this.connectedDeviceAddress,
        devices: devices ?? this.devices,
        alreadyAddedDevices: alreadyAddedDevices ?? this.alreadyAddedDevices,
      );

  @override
  List<Object?> get props => [
        devices,
        alreadyAddedDevices,
        connectedDeviceAddress,
      ];
}
