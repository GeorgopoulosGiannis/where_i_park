import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/features/bonded_devices/domain/entities/bluetooth_device.dart';
import 'package:where_i_park/features/bonded_devices/domain/usecases/load_bonded_devices.dart';
import 'package:where_i_park/features/cars/presentation/bloc/cars_bloc.dart';

part 'bonded_devices_event.dart';
part 'bonded_devices_state.dart';

@injectable
class BondedDevicesBloc extends Bloc<BondedDevicesEvent, BondedDevicesState> {
  final LoadBondedDevices loadBondedDevices;
  BondedDevicesBloc(this.loadBondedDevices) : super(Empty()) {
    _registerEvents();
    add(LoadBondedDevicesEvent());
  }

  void _registerEvents() {
    on<LoadBondedDevicesEvent>(_onLoadBondedDevicesEvent);
  }

  FutureOr<void> _onLoadBondedDevicesEvent(
    LoadBondedDevicesEvent event,
    Emitter<BondedDevicesState> emit,
  ) async {
    final failureOrDevices = await loadBondedDevices(NoParams());
    emit(
      failureOrDevices.fold(
        (left) => Error(left.message),
        (right) => right.isNotEmpty ? Loaded(right) : Empty(),
      ),
    );
  }
}
