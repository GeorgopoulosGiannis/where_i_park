part of 'add_device_bloc.dart';

abstract class AddDeviceEvent extends Equatable {
  const AddDeviceEvent();

  @override
  List<Object> get props => [];
}

class LoadPermissionsEvent extends AddDeviceEvent {}
class RequestPermissionsEvent extends AddDeviceEvent {}

class LoadDevicesEvent extends AddDeviceEvent {}

class LoadTrackingDevicesEvent extends AddDeviceEvent {}

class StartTrackingConnectedEvent extends AddDeviceEvent {}

class NewDeviceConnectionEvent extends AddDeviceEvent {
  final String address;

  const NewDeviceConnectionEvent(this.address);
}

class TrackDeviceEvent extends AddDeviceEvent {
  final BluetoothDevice device;

  const TrackDeviceEvent(this.device);
}

class RemoveTrackDeviceEvent extends AddDeviceEvent {
  final BluetoothDevice device;

  const RemoveTrackDeviceEvent(this.device);
}
