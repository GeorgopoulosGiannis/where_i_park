import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/features/add_device/domain/usecases/add_tracking_device.dart';
import 'package:where_i_park/features/add_device/domain/usecases/remove_tracking_device.dart';
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
  final RemoveTrackingDevice removeTrackingDevice;

  StreamSubscription<String?>? _subscription;

  AddDeviceBloc(
    this.addTrackingDevice,
    this.loadDevices,
    this.loadTrackingDevices,
    this.getConnectedDeviceSubject,
    this.removeTrackingDevice,
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
    on<RemoveTrackDeviceEvent>(_onRemoveTrackDeviceEvent);
  }

  FutureOr<void> _onLoadDevicesEvent(
    LoadDevicesEvent event,
    Emitter<AddDeviceState> emit,
  ) async {
    var allDevices = await loadDevices();
    var notTrackingDevices = <BluetoothDevice>[];
    if (state.alreadyAddedDevices.isNotEmpty) {
      notTrackingDevices = _getNonTracking(
        allDevices,
        state.alreadyAddedDevices,
      );
    } else {
      notTrackingDevices = allDevices;
    }
    emit(
      state.copyWith(
        devices: allDevices,
        devicesNotTracked: notTrackingDevices,
      ),
    );
  }

  FutureOr<void> _onLoadTrackingDevicesEvent(
    LoadTrackingDevicesEvent event,
    Emitter<AddDeviceState> emit,
  ) async {
    final allDevices = state.devices;
    final trackingDevices = await loadTrackingDevices();
    var nonTracking = <BluetoothDevice>[];
    if (allDevices.isNotEmpty) {
      nonTracking = _getNonTracking(allDevices, trackingDevices);
    } else {
      nonTracking = [];
    }
    emit(
      state.copyWith(
        alreadyAddedDevices: trackingDevices,
        devices: allDevices,
        devicesNotTracked: nonTracking,
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

  List<BluetoothDevice> _getNonTracking(
    List<BluetoothDevice> all,
    List<BluetoothDevice> tracking,
  ) {
    final result = <BluetoothDevice>[];
    for (var d in all) {
      bool isTracking = false;
      if (tracking.any((element) => element.address == d.address)) {
        isTracking = true;
      }
      if (!isTracking) {
        result.add(d);
      }
    }
    return result;
  }

  FutureOr<void> _onRemoveTrackDeviceEvent(
    RemoveTrackDeviceEvent event,
    Emitter<AddDeviceState> emit,
  ) async {
    final removed = await removeTrackingDevice(event.device);
    add(LoadTrackingDevicesEvent());
  }
}
