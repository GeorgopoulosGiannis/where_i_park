import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/get_connected_device.dart';

part 'app_event.dart';
part 'app_state.dart';

@singleton
class AppBloc extends Bloc<AppEvent, AppState> {
  final GetConnectedDevice getConnectedDevice;
  AppBloc(this.getConnectedDevice)
      : super(AppState(connectedDevice: getConnectedDevice())) {
    _registerEvents();
  }

  void _registerEvents() {
    on<DeviceConnected>(_onDeviceConnected);
    on<DeviceDisconnected>(_onDeviceDisconnected);
  }

  FutureOr<void> _onDeviceConnected(
    DeviceConnected event,
    Emitter<AppState> emit,
  ) async {
    emit(
      AppState(
        connectedDevice: event.device,
      ),
    );
  }

  FutureOr<void> _onDeviceDisconnected(
    DeviceDisconnected event,
    Emitter<AppState> emit,
  ) {
    emit(
      const AppState(
        connectedDevice: '',
      ),
    );
  }
}
