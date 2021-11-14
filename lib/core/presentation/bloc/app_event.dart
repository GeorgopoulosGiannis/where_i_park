part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class DeviceConnected extends AppEvent {
  final String device;

  const DeviceConnected(this.device);
}

class DeviceDisconnected extends AppEvent {}
