part of 'add_device_bloc.dart';

class AddDeviceState extends Equatable {
  final bool hasPermissions;
  final List<BluetoothDevice> devices;
  final List<BluetoothDevice> devicesNotTracked;

  final List<BluetoothDevice> alreadyAddedDevices;
  final String? connectedDeviceAddress;

  const AddDeviceState({
    this.hasPermissions = true,
    this.devices = const [],
    this.alreadyAddedDevices = const [],
    this.devicesNotTracked = const [],
    this.connectedDeviceAddress,
  });

  AddDeviceState copyWith({
    List<BluetoothDevice>? devices,
    List<BluetoothDevice>? alreadyAddedDevices,
    List<BluetoothDevice>? devicesNotTracked,
    String? connectedDeviceAddress,
    bool? hasPermissions,
  }) =>
      AddDeviceState(
        connectedDeviceAddress:
            connectedDeviceAddress ?? this.connectedDeviceAddress,
        devices: devices ?? this.devices,
        alreadyAddedDevices: alreadyAddedDevices ?? this.alreadyAddedDevices,
        devicesNotTracked: devicesNotTracked ?? this.devicesNotTracked,
        hasPermissions: hasPermissions ?? this.hasPermissions,
      );

  @override
  List<Object?> get props => [
        devices,
        alreadyAddedDevices,
        connectedDeviceAddress,
        devicesNotTracked,
        hasPermissions,
      ];
}
