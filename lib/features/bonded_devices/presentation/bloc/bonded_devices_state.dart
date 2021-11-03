part of 'bonded_devices_bloc.dart';

@immutable
abstract class BondedDevicesState extends Equatable {}

class Empty extends BondedDevicesState {
  @override
  List<Object?> get props => [];
}

class Loading extends BondedDevicesState {
  @override
  List<Object?> get props => [];
}

class Loaded extends BondedDevicesState {
  final List<BluetoothDevice> pairedDevices;

  Loaded(this.pairedDevices);
  @override
  List<Object?> get props => [pairedDevices];
}

class Error extends BondedDevicesState {
  final String message;

  Error(this.message);
  @override
  List<Object?> get props => [message];
}
