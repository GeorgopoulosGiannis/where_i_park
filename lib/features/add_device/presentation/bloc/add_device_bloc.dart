import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/features/add_device/domain/usecases/add_tracking_device.dart';
import '../../domain/entities/bluetooth_device.dart';
import '../../domain/usecases/get_connected_device_subject.dart';
import '../../domain/usecases/load_devices.dart';
import 'package:where_i_park/features/add_device/domain/usecases/load_tracking_devices.dart';

part 'add_device_event.dart';
part 'add_device_state.dart';

@injectable
class AddDeviceBloc extends Bloc<AddDeviceEvent, AddDeviceState> {
  final LoadDevices loadDevices;
  final LoadTrackingDevices loadTrackingDevices;
  final GetConnectedDeviceSubject getConnectedDeviceSubject;
  final AddTrackingDevice addTrackingDevice;

  StreamSubscription<String?>? _subscription;

  AddDeviceBloc(
    this.addTrackingDevice,
    this.loadDevices,
    this.loadTrackingDevices,
    this.getConnectedDeviceSubject,
  ) : super(const AddDeviceState()) {
    _registerEvents();
  }
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void _registerEvents() {
    on<LoadDevicesEvent>(_onLoadDevicesEvent);
    on<LoadTrackingDevicesEvent>(_onLoadTrackingDevicesEvent);
    on<StartTrackingConnectedEvent>(_onStartTrackingConnectedEvent);
    on<NewDeviceConnectionEvent>(_onNewDeviceConnectionEvent);
    on<TrackDeviceEvent>(_onTrackDeviceEvent);
  }

  FutureOr<void> _onLoadDevicesEvent(
    LoadDevicesEvent event,
    Emitter<AddDeviceState> emit,
  ) async {
    var devices = await loadDevices();
    if(state.alreadyAddedDevices.isNotEmpty){
      devices = _reorderDevices(devices, state.alreadyAddedDevices);
    }
    emit(
      state.copyWith(
        devices: devices,
      ),
    );
  }

  FutureOr<void> _onLoadTrackingDevicesEvent(
    LoadTrackingDevicesEvent event,
    Emitter<AddDeviceState> emit,
  ) async {
    final trackingDevices = await loadTrackingDevices();
    var allDevices = state.devices;
    if (allDevices.isNotEmpty) {
      allDevices = _reorderDevices(allDevices, trackingDevices);
    }
    emit(
      state.copyWith(
        alreadyAddedDevices: trackingDevices,
        devices: allDevices,
      ),
    );
  }

  FutureOr<void> _onStartTrackingConnectedEvent(
    StartTrackingConnectedEvent event,
    Emitter<AddDeviceState> emit,
  ) {
    _subscription = getConnectedDeviceSubject().listen(
      (address) {
        add(NewDeviceConnectionEvent(address));
      },
    );
  }

  FutureOr<void> _onNewDeviceConnectionEvent(
    NewDeviceConnectionEvent event,
    Emitter<AddDeviceState> emit,
  ) {
    emit(
      state.copyWith(
        connectedDeviceAddress: event.address,
      ),
    );
  }

  FutureOr<void> _onTrackDeviceEvent(
    TrackDeviceEvent event,
    Emitter<AddDeviceState> emit,
  ) async {
    final added = await addTrackingDevice(event.device);
    add(LoadTrackingDevicesEvent());
  }

  List<BluetoothDevice> _reorderDevices(
    List<BluetoothDevice> all,
    List<BluetoothDevice> tracking,
  ) {
    final result = <BluetoothDevice>[];
    for (var d in all) {
      bool isTracking = false;
      if (tracking.any((element) => element.address == d.address)) {
        isTracking = true;
      }

      result.insert(isTracking ? 0 : result.length, d);
    }
    return result;
  }
}
